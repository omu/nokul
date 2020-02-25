# frozen_string_literal: true

module Xokul
  module Configuration
    include ActiveSupport::Configurable

    config_accessor :endpoint,
                    :username,
                    :password,
                    :access_token,
                    :bearer_token, instance_writer: false
  end
end
