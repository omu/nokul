# frozen_string_literal: true

require 'active_support/all'
require 'json'
require 'net/http'
require 'openssl'
require 'uri'

module Nokul
  module Support
    # RestClient
    module RestClient
      SUPPORTED_HTTP_METHODS = %i[
        delete
        get
        patch
        post
        put
      ].freeze

      class Error < StandardError; end

      class HTTPMethodError < Error; end

      class HTTPOptionError < Error; end

      # Request
      class Request
        def initialize(method, url, header = {}, **http_options)
          @method = method
          @url    = url
          @header = header

          SUPPORTED_HTTP_METHODS.include?(method) || raise(HTTPMethodError, "Unsupported HTTP method: :#{method}")

          build_http_object(http_options)
        end

        def execute(payload = nil)
          klass = "Net::HTTP::#{method.capitalize}".constantize
          request = klass.new(url, header)

          Response.new(@http.request(request, payload))
        end

        SUPPORTED_HTTP_OPTIONS = {
          open_timeout: 60,
          read_timeout: 60,
          use_ssl: false,
          verify_mode: OpenSSL::SSL::VERIFY_NONE
        }.freeze

        private_constant :SUPPORTED_HTTP_OPTIONS

        protected

        attr_reader :method, :url, :header

        private

        def build_http_object(http_options)
          uri   = URI.parse(url)
          @http = Net::HTTP.new(uri.host, uri.port)

          unsupported_opts = http_options.keys - SUPPORTED_HTTP_OPTIONS.keys
          unsupported_opts.empty? || raise(HTTPOptionError, "Unsupported HTTP options: #{unsupported_opts}")

          http_options.each do |option, value|
            @http.send("#{option}=", value)
          end
        end
      end

      private_constant :Request

      Response = Struct.new(:http_response) do
        delegate :body, to: :http_response

        def code
          http_response.code.to_i
        end

        def decode
          JSON.parse(body)
        end

        def error!
          http_response.error! unless [200, 204].include?(code)
        end

        def ok?
          code.eql?(200)
        end
      end

      private_constant :Response

      module_function

      SUPPORTED_HTTP_METHODS.each do |method|
        define_method(method) do |url, header: {}, payload: nil, **http_options|
          Request.new(method, url, header, **http_options).execute(payload)
        end
      end
    end
  end
end
