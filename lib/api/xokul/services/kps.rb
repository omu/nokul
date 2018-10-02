# frozen_string_literal: true

module Xokul
  module Kps
    module_function

    def identity(id_number:)
      connection.get '/kps/queries/identities', params: { id_number: id_number }
    end

    def address(id_number:)
      connection.get '/kps/queries/addresses',  params: { id_number: id_number }
    end

    def connection
      Connection.instance
    end

    private_class_method :connection
  end
end
