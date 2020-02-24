# frozen_string_literal: true

module Xokul
  class Connection
    attr_reader :endpoint, :headers

    def initialize(endpoint)
      @endpoint = endpoint
      @headers  = { 'Content-Type' => 'application/json' }
    end

    def get(path = nil, params: {})
      url = URI.join(endpoint, path.to_s).to_s

      r = Support::REST.get(url, headers: headers, payload: params.to_json, **ssl_opts)
      r.error!

      JSON.parse(r.body)
    end

    def paginate; end

    def bearer_auth(bearer_token)
      headers['Authorization'] = "Bearer #{bearer_token}"
    end

    private

    def ssl_opts
      { use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_PEER }
    end
  end
end
