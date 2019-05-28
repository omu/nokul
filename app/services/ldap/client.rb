# frozen_string_literal: true

module Ldap
  class Client
    include Singleton

    attr_reader :client

    def initialize
      @username = 'cn=admin,dc=test,dc=omu,dc=edu,dc=tr'
      @password = '12345'
      @host     = 'ldap.vagrant.ga'
      @client   = generate_client
    end

    private

    attr_reader :host, :username, :password

    def generate_client
      Net::LDAP.new(
        host: host,
        port: 389,
        auth: {
          method: :simple,
          username: username,
          password: password
        }
      )
    end

    Error = Class.new(StandardError)

    class << self
      # entity: a record of the LdapEntity
      # Usage:
      #  Ldap::Client.create(entity)
      def create(entity)
        run(:add, dn: entity.dn, attributes: entity.values)
      end

      # entity: a record of the LdapEntity
      # Usage:
      #  Ldap::Client.update(entity)
      #  Ldap::Client.create_or_update(entity)
      def update(entity)
        return create(entity) unless LdapEntity.synchronized_for_user(entity.user)

        operations = generate_update_operations(entity.prev.values, entity.values)

        return true if operations.blank?

        run(:modify, dn: entity.dn, operations: operations)
      end

      alias create_or_update update

      # entity: a record of the LdapEntity
      # Usage:
      #  Ldap::Client.destroy(entity)
      def destroy(entity)
        run(:delete, dn: entity.dn)
      end

      def response
        instance.client.get_operation_result
      end

      private

      def run(action, **parameters)
        instance.client.public_send(action, parameters) || raise(Error, response.message)
      end

      # Single level diff between two entities
      # [
      #   [:replace, "userPassword", "{BCRYPT}PASSWORD"],
      #   [:delete, "jpegPhoto", nil],
      #   [:add, "eduPersonPrincipalNamePrior", "onceki_username"]
      # ]
      def generate_update_operations(first, last)
        result = []

        last.each do |key, value|
          next if first.key?(key) && first[key].eql?(value)

          operation = first.key?(key) ? :replace : :add
          result << [operation, key, value]
        end

        first.each do |key, _|
          result << [:delete, key, nil] unless last.key?(key)
        end

        result
      end
    end
  end
end
