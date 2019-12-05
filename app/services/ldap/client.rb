# frozen_string_literal: true

module LDAP
  class Client
    include Singleton

    attr_reader :client

    def initialize
      @username = configuration[:username]
      @password = configuration[:password]
      @host     = configuration[:host]
      @port     = configuration[:port]
      @client   = generate_client
    end

    private

    attr_reader :host, :username, :password, :port

    def generate_client
      Net::LDAP.new(
        host:            host,
        port:            port,
        connect_timeout: 1, # seconds
        auth:            {
          method:   :simple,
          username: username.to_s,
          password: password.to_s
        }
      )
    end

    def configuration
      @configuration ||= Tenant.credentials.ldap
    end

    Error = Class.new(StandardError)

    class << self
      def active?
        instance.client.bind
      rescue Net::LDAP::Error
        false
      end

      # entity: a record of the LdapEntity
      # Usage:
      #  LDAP::Client.create(entity)
      def create(entity)
        run!(:add, dn: entity.dn, attributes: entity.values)
      end

      # entity: a record of the LdapEntity
      # Usage:
      #  LDAP::Client.update(entity)
      #  LDAP::Client.create_or_update(entity)
      def update(entity)
        return create(entity) unless exists?(entity)

        operations = build_operations_for_update(entity)
        return true if operations.blank?

        run!(:modify, dn: entity.dn, operations: operations)
      end

      alias create_or_update update

      # entity: a record of the LdapEntity
      # Usage:
      #  LDAP::Client.destroy(entity)
      def destroy(entity)
        run!(:delete, dn: entity.dn) if exists?(entity)
      end

      # Usage:
      #   LDAP::Client.where('dc=test, dc=com, dc=tr',
      #                      filter: Net::LDAP::Filter.eq('uid', 'Foo'))
      def where(base, filter:, **options)
        base = base.split(',')
                   .select { |item| item.include?('dc=') }
                   .join(',')

        run!(:search, base: base, filter: filter, **options)
      end

      # Usage:
      #   LDAP::Client.find_by('dc=test, dc=com, dc=tr', uid: '11223344550')
      def find_by(base, **queries)
        queries = queries.map    { |key, value| Net::LDAP::Filter.eq(key, value) }
                         .inject { |first, last| first | last }

        where(base, filter: queries).first
      end

      # entity: a record of the LdapEntity
      # Usage:
      #  LDAP::Client.exists?(entity)
      def exists?(entity)
        response = find_by(entity.dn, uid: entity.uid)
        response.present?
      end

      def response
        instance.client.get_operation_result
      end

      private

      def run!(action, **parameters)
        raise(Error, 'Service unavailable or authentication failed') unless active?

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
        operations       = []

        values.each do |key, value|
          next if current_values.key?(key) && current_values[key].eql?(value)

          operations << [(current_values.key?(key) ? :replace : :add), key, value]
        end

        current_values.each { |key, _| operations << [:delete, key, nil] unless values.key?(key) }

        operations
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
