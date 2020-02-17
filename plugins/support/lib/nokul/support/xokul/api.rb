# frozen_string_literal: true

module Xokul
  class API
    include ActiveSupport::Configurable

    config_accessor :synopsis, :version, instance_writer: false

    def initialize(*)
      @conn = Connection.new(Configuration.endpoint)
      @conn.bearer_auth Configuration.bearer_token
    end

    protected

    attr_reader :conn
  end
end
