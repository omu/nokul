# frozen_string_literal: true

module Xokul
  module Connection
    BASE_URL     = Rails.application.config.tenant.api_host
    BEARER_TOKEN = Rails.application.credentials.xokul[:bearer_token]

    # rubocop:disable Metrics/MethodLength
    def self.request(path, params: {})
      response = RestClient.get(
        File.join(BASE_URL, path),
        header:  {
          Authorization: "Bearer #{BEARER_TOKEN}",
          'Content-Type': 'application/json'
        },
        payload: params,
        use_ssl: true,
        verify_mode: OpenSSL::SSL::VERIFY_PEER
      )

      response.error!

      unmarshal = response.unmarshal_json
      unmarshal.is_a?(Hash) ? unmarshal.deep_symbolize_keys : unmarshal
    end
    # rubocop:enable Metrics/MethodLength
  end

  private_constant :Connection
end
