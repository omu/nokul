# frozen_string_literal: true

module Xokul
  class Connection
    include Authentication

    attr_reader :http

    delegate :get, :post, :put, to: :@http

    def initialize
      @http = HTTP.persistent(Configuration.endpoint)
      authenticate
    end
  end
end
