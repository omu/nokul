# frozen_string_literal: true

module Xokul
  class Kps
    def initialize
      @connection = Faraday.new(url: BASE_URL + '/kps/queries/')
      @connection.authorization :Bearer, BEARER_TOKEN
    end

    def identity(id_number)
      query_builder('identities', id_number)
    end

    def address(id_number)
      query_builder('addresses', id_number)
    end

    def query_builder(path, id_number)
      response = @connection.get do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['Accept'] = 'application/json'
        request.url path
        request.body = '{"id_number": %{id_number}}' % {id_number: id_number}
      end

      response.body if response.status.eql?(200)
    end
  end
end
