# frozen_string_literal: true

module Xokul
  module Yoksis
    module Graduates
      module_function

      def informations(id_number:)
        connection.get '/yoksis/graduates/informations', params: { id_number: id_number }
      end

      def connection
        Connection.instance
      end

      private_class_method :connection
    end
  end
end
