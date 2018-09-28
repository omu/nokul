# frozen_string_literal: true

module Xokul
  BASE_URL = Rails.application.config.tenant.api_host
  BEARER_TOKEN = Rails.application.credentials.xokul[:bearer_token]
end
