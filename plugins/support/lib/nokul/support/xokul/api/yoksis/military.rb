# frozen_string_literal: true

module Xokul
  module Yoksis
    class Military < Endpoint
      configure do |config|
        config.synopsis  = "Get someone's military status from YOKSIS"
        config.version   = '1'
        config.namespace = '/yoksis/military'
      end

      def status(id_number)
        conn.get :status, params: { id_number: id_number }
      end
    end
  end
end
