# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

# simplecov and codacy coverage
require 'simplecov'
require 'codacy-coverage' if ENV['CI']
SimpleCov.start 'rails' do
  add_filter '/app/channels'
end
Codacy::Reporter.start if ENV['CI']

require 'minitest/autorun'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    include AbstractController::Translation # Use t() in tests, instead of I18n.t()
    fixtures :all
  end
end
