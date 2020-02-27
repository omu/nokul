# frozen_string_literal: true

module Xokul
  module Configuration
    include ActiveSupport::Configurable

    # Initialize with default endpoint
    config_accessor :endpoint do
      Default::ENDPOINT
    end

    # Authentication related configurations
    config_accessor :user, :password, :access_token, :bearer_token

    # Advanced logging instrumenter
    config_accessor :instrumenter do
      Default::INSTRUMENTER
    end
  end
end
