# frozen_string_literal: true

module Xokul
  BASE_URL     = Rails.application.config.tenant.api_host
  BEARER_TOKEN = Rails.application.credentials.xokul[:bearer_token]

  class Connection
    include Singleton

    def initialize(endpoint = BASE_URL, bearer_token: BEARER_TOKEN)
      @bearer_token = bearer_token

      uri               = URI.parse(endpoint)
      @http             = Net::HTTP.new uri.host, uri.port
      @http.use_ssl     = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    # rubocop:disable Metrics/AbcSize
    def get(path, params: {})
      request = Net::HTTP::Get.new path, Authorization: "Bearer #{@bearer_token}"

      request.add_field 'Content-Type', 'application/json'
      request.add_field 'Accept', 'application/json'

      response = @http.request request, params.to_json
      response.error! unless response.code.eql? '200'

      JSON.parse(response.body).deep_symbolize_keys
    rescue StandardError
      raise response.error_type.new response.body, response
    end
    # rubocop:enable Metrics/AbcSize
  end

  private_constant :Connection
end
