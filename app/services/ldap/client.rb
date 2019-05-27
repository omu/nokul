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

    class << self
      def create(entity)
        instance.client.add(dn: entity.dn, attributes: entity.values)
      end

      def update(_entity)
        put 'Updating...'
      end

      def destroy(entity)
        instance.client.delete(dn: entity.dn)
      end

      def results
        instance.client.get_operation_result
      end
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
  end
end
