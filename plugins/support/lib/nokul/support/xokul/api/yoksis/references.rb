# frozen_string_literal: true

module Xokul
  module Yoksis
    class References < API
      configure do |config|
        config.synopsis = 'Get references provided by YOKSIS'
        config.version  = '1'
      end

      def cities
        conn.get '/yoksis/references/cities'
      end
    end
  end
end
