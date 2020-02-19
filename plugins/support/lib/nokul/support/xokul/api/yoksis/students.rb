# frozen_string_literal: true

module Xokul
  module Yoksis
    class Students < Endpoint
      configure do |config|
        config.synopsis  = 'Get student related information from YOKSIS'
        config.version   = '1'
        config.namespace = '/yoksis/students'
      end

      def information(id_number)
        conn.get :information, params: { id_number: id_number }
      end
    end
  end
end
