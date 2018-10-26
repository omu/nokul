# frozen_string_literal: true

module RestClient
  SUPPORTED_HTTP_METHODS = %i[
    get
    delete
    patch
    post
    put
  ].freeze

  private_constant :SUPPORTED_HTTP_METHODS

  class Request
    class Error < StandardError; end

    class HTTPMethodError < Error; end

    attr_accessor :method, :url

    def initialize(method:, url:, **options)
      @method = method
      @url    = url

      build_http_object options
    end

    # rubocop:disable Style/IfUnlessModifier
    def execute(path: nil, header: {}, payload: {})
      unless method.in?(SUPPORTED_HTTP_METHODS)
        raise HTTPMethodError, "Undefined HTTP method: #{method}"
      end

      path ||= @uri.request_uri

      klass = "Net::HTTP::#{method.capitalize}".constantize
      request = klass.new path, header

      Response.new @http.request request, payload.to_json
    end
    # rubocop:enable Style/IfUnlessModifier

    private

    def build_http_object(options)
      @uri              = URI.parse(url)
      @http             = Net::HTTP.new @uri.host, @uri.port
      @http.use_ssl     = options[:use_ssl] || false
      @http.verify_mode = options[:verify_mode] || nil
    end
  end

  private_constant :Request

  Response = Struct.new(:http_response) do
    delegate :body, to: :http_response

    def code
      @http_response.code.to_i
    end

    def error!
      @http_response.error! unless code.eql? 200
    end

    def unmarshal_json
      body && JSON.parse(body)
    end
  end

  private_constant :Response

  module_function

  SUPPORTED_HTTP_METHODS.each do |method|
    define_method(method) do |url:, header: {}, payload: {}, **options|
      Request.new(method: method, url: url, **options).execute(
        header: header, payload: payload
      )
    end
  end
end
