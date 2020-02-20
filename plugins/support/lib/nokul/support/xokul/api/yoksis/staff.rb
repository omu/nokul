# frozen_string_literal: true

module Xokul
  module Yoksis
    class Staff < Endpoint
      configure do |config|
        config.namespace        = '/yoksis/staff'
        config.upstream_version = '1'
      end

      def academicians(id_number)
        conn.get :academicians, params: { id_number: id_number }
      end

      def nationalities
        conn.get :nationalities
      end

      def pages(page)
        conn.get :pages, params: { page: page }, read_timeout: 15
      end

      def total_pages
        r = conn.get :total_pages
        r[:result]
      end
    end
  end
end
