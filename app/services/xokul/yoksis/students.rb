# frozen_string_literal: true

module Xokul
  module Yoksis
    module Students
      module_function

      def informations(id_number:)
        Connection.request(
          '/yoksis/students/informations', params: { id_number: id_number }
        )
      end
    end
  end
end
