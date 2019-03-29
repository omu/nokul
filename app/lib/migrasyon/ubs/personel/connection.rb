# frozen_string_literal: true

module Migrasyon
  module Ubs
    module Personel
      class Connection
        attr_reader :client

        def initialize
          credentials = Tenant.credentials.ubs_personel

          @client = TinyTds::Client.new(
            username: credentials[:username],
            password: credentials[:password],
            host: credentials[:host],
            port: 1433,
            database: credentials[:database]
          )
        end

        def active?
          @client.active?
        end

        def close
          @client.close
        end
      end
    end
  end
end
