# frozen_string_literal: true

module Xokul
  module Connection
    BASE_URL        = Tenant.configuration.api_host
    BEARER_TOKEN    = Tenant.credentials.dig(:xokul, :bearer_token)
    DEFAULT_OPTIONS = {
      headers:     {
        'Authorization' => "Bearer #{BEARER_TOKEN}",
        'Content-Type'  => 'application/json'
      },
      use_ssl:     true,
      verify_mode: OpenSSL::SSL::VERIFY_PEER
    }.freeze

    private_constant :BASE_URL, :BEARER_TOKEN, :DEFAULT_OPTIONS

    def self.request(path, params: {}, **options)
      options[:open_timeout] ||= options[:read_timeout] ||= 10 if Rails.env.test?

      response = Support::RestClient.get(
        URI.join(BASE_URL, path).to_s, payload: params.to_json, **DEFAULT_OPTIONS.merge(options)
      )

      response.error! unless response.success?
      decode(response.body)
    rescue Net::HTTPError => e
      warn e
    end

    def self.decode(data)
      return unless data

      JSON.parse(data)
    rescue JSON::ParserError
      warn "Unparseable object: #{object}"
    end
  end

  private_constant :Connection
end
