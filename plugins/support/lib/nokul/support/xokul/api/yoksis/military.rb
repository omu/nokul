# frozen_string_literal: true

module Xokul
  module Yoksis
    class Military < Endpoint
      configure do |config|
        config.synopsis         = "Get someone's military status from YOKSIS"
        config.namespace        = '/yoksis/military'
        config.upstream_version = '1'
      end

      def status(id_number)
        conn.get :status, params: { id_number: id_number }
      end
    end
  end
end
