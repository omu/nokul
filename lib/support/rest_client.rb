# frozen_string_literal: true

module RestClient
  SUPPORTED_HTTP_METHODS = %i[
    delete
    get
    patch
    post
    put
  ].freeze

  private_constant :SUPPORTED_HTTP_METHODS

  class Error < StandardError; end

  class HTTPMethodError < Error; end

  class UnmarshalJSONError < Error; end

  class UnsupportedHTTPOptionError < Error; end

  class Request
    SUPPORTED_HTTP_OPTIONS = {
      open_timeout: 60,
      read_timeout: 60,
      use_ssl: false,
      verify_mode: OpenSSL::SSL::VERIFY_NONE
    }.freeze

    private_constant :SUPPORTED_HTTP_OPTIONS

    # rubocop:disable Style/IfUnlessModifier
    def initialize(method, url, headers = {}, **http_options)
      @method  = method
      @url     = url
      @headers = headers

      unless method.in?(SUPPORTED_HTTP_METHODS)
        raise HTTPMethodError, "unsupported HTTP method: #{method}"
      end

      build_http_object http_options
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

    def build_http_object(http_options)
      uri   = URI.parse(url)
      @http = Net::HTTP.new uri.host, uri.port

      unsupported_options = http_options.keys - SUPPORTED_HTTP_OPTIONS.keys
      unless unsupported_options.empty?
        raise UnsupportedHTTPOptionError, "unsupported HTTP options: #{unsupported_options}"
      end

      http_options.each { |option, value| @http.send "#{option}=", value }
    end
  end

  private_constant :Request

  Response = Struct.new(:http_response) do
    delegate :body, to: :http_response

    def code
      http_response.code.to_i
    end

    def error!
      http_response.error! unless code.eql? 200
    end

    def unmarshal_json
      JSON.parse(body || '')
    rescue JSON::ParserError
      raise UnmarshalJSONError, 'response body is not parseable'
    end
  end

  private_constant :Response

  module_function

  SUPPORTED_HTTP_METHODS.each do |method|
    define_method(method) do |url, headers: {}, payload: nil, **http_options|
      Request.new(method, url, headers, **http_options).execute(payload)
    end
  end
end
