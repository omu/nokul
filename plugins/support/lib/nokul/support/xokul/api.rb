# frozen_string_literal: true

require_relative 'api/yoksis'

module Xokul
  class API
    include ActiveSupport::Configurable

    config_accessor :namespace, :version, instance_writer: false

    def initialize(*)
      @conn = Connection.new(Configuration.endpoint)
      @conn.bearer_auth Configuration.bearer_token
    end

    protected

    attr_reader :conn

    private

    def request(path, params: {})
      url  = URI.join(namespace, path).to_s
      resp = conn.get(url, params: params)
      resp.decode
    end
  end
end
