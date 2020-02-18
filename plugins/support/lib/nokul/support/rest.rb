# frozen_string_literal: true

require 'openssl'

module Nokul
  module Support
    module REST
      HTTP_METHODS = %i[
        delete
        get
        patch
        post
        put
      ].freeze

      private_constant :HTTP_METHODS

      class Error < StandardError; end

      class HTTPMethodError < Error; end

      class HTTPOptionError < Error; end

      class HTTPError < Error; end

      class Request
        HTTP_OPTIONS = {
          open_timeout: 10,
          read_timeout: 10,
          use_ssl: false,
          verify_mode: OpenSSL::SSL::VERIFY_NONE
        }.freeze

        private_constant :HTTP_OPTIONS

        # rubocop:disable Style/IfUnlessModifier
        def initialize(method, url, headers = {}, **http_opts)
          @method  = method
          @url     = url
          @headers = headers

          unless method.in?(HTTP_METHODS)
            raise HTTPMethodError, "invalid HTTP method: #{method}"
          end

          build_http_object http_opts
        end
        # rubocop:enable Style/IfUnlessModifier

        def execute(payload = nil)
          klass = "Net::HTTP::#{method.capitalize}".constantize
          request = klass.new url, headers
          Response.new @http.request(request, payload)
        end

        protected

        attr_reader :method, :url, :headers

        private

        def build_http_object(http_opts)
          uri   = URI.parse(url)
          @http = Net::HTTP.new uri.host, uri.port

          invalid_opts = http_opts.keys - HTTP_OPTIONS.keys

          raise HTTPOptionError, "invalid HTTP options: #{invalid_opts}" unless invalid_opts.empty?

          http_opts.each { |option, value| @http.send "#{option}=", value }
        end
      end

      private_constant :Request

      Response = Struct.new(:http_response) do
        delegate :body, to: :http_response

        def error!
          http_response.error! unless ok?
        rescue Net::HTTPError, Net::HTTPFatalError => e
          raise HTTPError
        end

        def ok?
          http_response.is_a?(Net::HTTPOK)
        end
      end

      private_constant :Response

      module_function

      HTTP_METHODS.each do |method|
        define_method(method) do |url, headers: {}, payload: nil, **http_opts|
          Request.new(method, url, headers, **http_opts).execute(payload)
        end
      end
    end
  end
end
