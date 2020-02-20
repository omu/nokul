# frozen_string_literal: true

module Xokul
  module Yoksis
    class Graduates < Endpoint
      configure do |config|
        config.namespace        = '/yoksis/graduates'
        config.upstream_version = '1'
      end

      def information(id_number)
        conn.get :information, params: { id_number: id_number }
      end
    end
  end
end
