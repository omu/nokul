# frozen_string_literal: true

module Xokul
  class Endpoint
    include ActiveSupport::Configurable

    config_accessor :namespace, :upstream_version, instance_writer: false

    def initialize
      url   = URI.join(Configuration.endpoint, namespace.chomp('/') + '/').to_s
      @conn = Connection.new(url)
      @conn.bearer_auth Configuration.bearer_token

      after_initialize!
    end

    def after_initialize!; end

    protected

    attr_reader :conn
  end
end
