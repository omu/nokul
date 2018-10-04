# frozen_string_literal: true

module Xokul
  module Yoksis
    module Staff
      module_function

      def academicians(id_number:)
        Connection.instance.get(
          '/yoksis/staff/academicians', params: { id_number: id_number }
        )
      end

      def nationalities
        Connection.instance.get '/yoksis/staff/nationalities'
      end

      def pages(page:)
        Connection.instance.get '/yoksis/staff/pages', params: { page: page }
      end
    end
  end
end
