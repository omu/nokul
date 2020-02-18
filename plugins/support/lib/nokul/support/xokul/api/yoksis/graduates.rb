# frozen_string_literal: true

module Xokul
  module Yoksis
    class Graduates < API
      configure do |config|
        config.synopsis  = "Get someone's graduation information from YOKSIS"
        config.version   = '1'
        config.namespace = '/yoksis/graduates/'
      end

      def information(id_number)
        conn.get 'information', params: { id_number: id_number }
      end
    end
  end
end
