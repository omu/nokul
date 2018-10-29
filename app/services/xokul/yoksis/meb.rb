# frozen_string_literal: true

module Xokul
  module Yoksis
    module Meb
      module_function

      def students(id_number:)
        Connection.request(
          '/yoksis/meb/students', params: { id_number: id_number }
        )
      end
    end
  end
end
