# frozen_string_literal: true

module Xokul
  module Yoksis
    module Graduates
      module_function

      def informations(id_number:)
        Connection.instance.get(
          '/yoksis/graduates/informations', params: { id_number: id_number }
        )
      end
    end
  end
end
