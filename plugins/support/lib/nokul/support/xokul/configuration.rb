# frozen_string_literal: true

module Xokul
  module Configuration
    include ActiveSupport::Configurable

    # Initialize with default endpoint
    config_accessor :endpoint do
      Default::ENDPOINT
    end

    # Authentication related configurations
    config_accessor :username, :password, :access_token, :bearer_token
  end
end
