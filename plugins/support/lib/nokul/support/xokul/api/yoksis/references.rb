# frozen_string_literal: true

module Xokul
  module Yoksis
    module References
      module_function

      def cities
        Connection.get '/yoksis/references/cities'
      end
    end
  end
end
