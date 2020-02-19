# frozen_string_literal: true

module Xokul
  class API
    include ActiveSupport::Configurable

    config_accessor :synopsis, :version, :namespace, instance_writer: false

    attr_reader :request_url

    def initialize
      @request_url = URI.join(Configuration.endpoint, namespace.chomp('/') + '/').to_s
      @conn = Connection.new(@request_url)
      @conn.bearer_auth Configuration.bearer_token

      after_initialize!
    end

    def after_initialize!; end

    protected

    attr_reader :conn
  end
end
