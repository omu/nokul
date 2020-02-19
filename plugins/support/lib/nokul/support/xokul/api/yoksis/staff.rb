# frozen_string_literal: true

module Xokul
  module Yoksis
    class Staff < API
      configure do |config|
        config.synopsis  = 'Get staff related information from YOKSIS'
        config.version   = '1'
        config.namespace = '/yoksis/staff'
      end

      def academicians(id_number)
        conn.get '/academicians', params: { id_number: id_number }
      end

      def nationalities
        conn.get '/nationalities'
      end

      def pages(page)
        conn.get '/pages', params: { page: page }, read_timeout: 15
      end

      # TODO: YOKSIS provides a terrible pagination mechanism. However, pagination
      # can be managed well in the client code.
      def total_pages
        r = conn.get '/total_pages'
        r[:result]
      end
    end
  end
end
