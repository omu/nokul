# frozen_string_literal: true

module Xokul
  module Configuration
    include ActiveSupport::Configurable

    config_accessor :endpoint, :bearer_token
  end
end
