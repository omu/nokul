# frozen_string_literal: true

module Xokul
  module Connection
    module_function

    def get(path, params: {})
      url = URI.join(Configuration.endpoint, path)
      Support::REST.get(url.to_s, headers: headers, payload: params.to_json, use_ssl: true)
    end
  end
end
