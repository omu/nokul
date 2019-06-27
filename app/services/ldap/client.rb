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
          method:   :simple,
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
        run!(:add, dn: entity.dn, attributes: entity.values)
      end

      # entity: a record of the LdapEntity
      # Usage:
      #  Ldap::Client.update(entity)
      #  Ldap::Client.create_or_update(entity)
      def update(entity)
        return create(entity) unless exists?(entity)

        operations = build_operations_for_update(entity)
        return true if operations.blank?

        run!(:modify, dn: entity.dn, operations: operations)
      end

      alias create_or_update update

      # entity: a record of the LdapEntity
      # Usage:
      #  Ldap::Client.destroy(entity)
      def destroy(entity)
        run!(:delete, dn: entity.dn)
      end

      # Usage:
      #   Ldap::Client.where('dc=test, dc=com, dc=tr',
      #                      filter: Net::LDAP::Filter.eq('uid', 'Foo'))
      def where(base, filter:, **options)
        base = base.split(',')
                   .select { |item| item.include?('dc=') }
                   .join(',')

        run!(:search, base: base, filter: filter, **options)
      end

      # Usage:
      #   Ldap::Client.find_by('dc=test, dc=com, dc=tr', uid: '11223344550')
      def find_by(base, **queries)
        queries = queries.map    { |key, value| Net::LDAP::Filter.eq(key, value) }
                         .inject { |first, last| first | last }

        where(base, filter: queries).first
      end

      # entity: a record of the LdapEntity
      # Usage:
      #  Ldap::Client.exists?(entity)
      def exists?(entity)
        response = find_by(entity.dn, uid: entity.uid)
        response.present?
      end

      def response
        instance.client.get_operation_result
      end

      private

      def run!(action, **parameters)
        instance.client.public_send(action, parameters) || raise(Error, response.message)
      end

      # Single level diff between two entities
      # [
      #   [:replace, "userPassword", "{BCRYPT}PASSWORD"],
      #   [:delete, "jpegPhoto", nil],
      #   [:add, "eduPersonPrincipalNamePrior", "onceki_username"]
      # ]
      def build_operations_for_update(entity)
        current_values   = find_values_via_ldap(entity).with_indifferent_access
        values           = entity.values.with_indifferent_access
        variances        = []

        values.each do |key, value|
          next if current_values.key?(key) && current_values[key].eql?(value)

          variances << [(current_values.key?(key) ? :replace : :add), key, value]
        end

        current_values.each { |key, _| variances << [:delete, key, nil] unless values.key?(key) }

        variances
      end

      def find_values_via_ldap(entity)
        current_values = find_by(entity.dn, uid: entity.uid)
        Entity::ATTRIBUTES.each_with_object({}) do |(attribute, type), hash|
          value           = current_values.public_send(attribute.downcase)
          hash[attribute] = (type == :single ? value.first : value)
        rescue NoMethodError
          next
        end
      end
    end
  end
end
