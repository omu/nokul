# frozen_string_literal: true

module Xokul
  module Connection
    BASE_URL     = Rails.application.config.tenant.api_host
    BEARER_TOKEN = Rails.application.credentials.xokul[:bearer_token]

    private_constant :BASE_URL, :BEARER_TOKEN

    # rubocop:disable Metrics/MethodLength
    def self.request(path, params: {}, **http_options)
      http_options[:open_timeout] ||= http_options[:read_timeout] ||= 5 if Rails.env.test?

      response = RestClient.get(
        URI.join(BASE_URL, path).to_s,
        headers: {
          'Authorization' => "Bearer #{BEARER_TOKEN}",
          'Content-Type' => 'application/json'
        },
        payload: params.to_json,
        use_ssl: true,
        verify_mode: OpenSSL::SSL::VERIFY_PEER,
        **http_options
      )

      response.error!

      unmarshal = response.unmarshal_json
      case unmarshal
      when Array
        unmarshal.map(&:deep_symbolize_keys)
      when Hash
        unmarshal.deep_symbolize_keys
      else
        unmarshal
      end
    end
    # rubocop:enable Metrics/MethodLength
  end

  private_constant :Connection
end
