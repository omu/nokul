# frozen_string_literal: true

require_relative 'api/yoksis'

module Xokul
  class API
    def initialize
      @conn = Connection.new(Configuration.endpoint)
      @conn.bearer_auth Configuration.bearer_token
    end

    protected

    attr_reader :conn
  end
end
