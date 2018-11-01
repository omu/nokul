# frozen_string_literal: true

require 'test_helper'
require 'webmock/minitest'

class RestClientTest < ActiveSupport::TestCase
  setup do
    @insecure_url = 'http://example.com'
    @secure_url   = 'https://example.com'
  end

  %i[
    delete
    get
    patch
    post
    put
  ].each do |method|
    test "makes sure that :#{method} works correctly" do
      stub_request method, @insecure_url

      assert RestClient.send method, @insecure_url
    end
  end

  test 'makes sure that http options work correctly' do
    stub_request :post, @secure_url

    assert RestClient.post @secure_url, use_ssl: true
  end

  test 'raises error if called with unsupported method' do
    url = @insecure_url + '/method_error'
    stub_request :get, url

    assert_raise RestClient::HTTPMethodError do
      RestClient.const_get(:Request).new(:foo, url).execute
    end
  end

  test 'raises error if called with unsupported http options' do
    url = @insecure_url + '/options_error'
    stub_request :get, url

    assert_raise RestClient::UnsupportedHTTPOptionError do
      RestClient.get url, foo: 'bar', baz: 'bar'
    end
  end

  test 'makes sure that :code and :body work correctly' do
    url = @insecure_url + '/ok'
    stub_request(:get, url).to_return status: 200

    response = RestClient.get url

    assert_equal response.code, 200
    assert_empty response.body
  end

  test 'makes sure that :unmarshal_json works correctly' do
    json_url = @insecure_url + '/json'
    text_url = @insecure_url + '/text'

    stub_request(:get, json_url).to_return body: '{ "foo": "bar" }'
    stub_request(:get, text_url).to_return body: 'foo'

    json_response = RestClient.get json_url
    text_response = RestClient.get text_url

    assert_equal json_response.unmarshal_json, 'foo' => 'bar'
    assert_raise RestClient::UnmarshalJSONError do
      text_response.unmarshal_json
    end
  end

  test 'checks whether the request header is correct' do
    url = @secure_url + '/headers'
    stub_request(:get, url).with headers: { foo: 'bar' }

    assert RestClient.get url, headers: { foo: 'bar' }, use_ssl: true
  end

  test 'makes sure that :error! works correctly' do
    url = @insecure_url + '/fail'
    stub_request(:post, url).to_return status: 500

    assert_raise Net::HTTPFatalError do
      RestClient.post(url).error!
    end
  end
end
