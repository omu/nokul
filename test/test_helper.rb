# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'minitest/autorun'

# simplecov and codacy coverage
require 'simplecov'
require 'codacy-coverage' if ENV['CI']
SimpleCov.start 'rails' do
  add_filter '/app/channels'
end
Codacy::Reporter.start if ENV['CI']

require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
  end
end
