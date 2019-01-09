# frozen_string_literal: true

require 'nokul/support/rest_client'

module Nokul
  # Xokul
  module Xokul
    BEARER_TOKEN = ENV['BEARER_TOKEN']

    module_function

    def request(endpoint, params = {})
      response = Support::RestClient.get(
        endpoint,
        header: {
          'Authorization': "Bearer #{BEARER_TOKEN}",
          'Content-Type': 'application/json'
        },
        payload: params.to_json,
        use_ssl: true
      )

      response.error! || response
    end
  end
end
