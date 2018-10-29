# frozen_string_literal: true

module Xokul
  module Connection
    BASE_URL     = Rails.application.config.tenant.api_host
    BEARER_TOKEN = Rails.application.credentials.xokul[:bearer_token]

    def self.request(path, params: {})
      response = RestClient.get(
        File.join(BASE_URL, path),
        header:  {
          Authorization: "Bearer #{Rails.application.credentials.xokul[:bearer_token]}",
          'Content-Type': 'application/json'
        }, payload: params
      )

      response.error!
      unmarshal = response.unmarshal_json
      unmarshal.is_a?(Hash) ? unmarshal.deep_symbolize_keys : unmarshal
    end
  end

  private_constant :Connection
end
