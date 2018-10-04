# frozen_string_literal: true

module Xokul
  module Yoksis
    module Military
      module_function

      def informations(id_number:)
        Connection.instance.get '/yoksis/military/informations', params: { id_number: id_number }
      end
    end
  end
end
