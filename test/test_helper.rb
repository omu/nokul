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
    include AbstractController::Translation
    include Devise::Test::IntegrationHelpers
    fixtures :all

    def controller_name
      @controller_name ||= class_name.delete_suffix('ControllerTest').underscore
    end

    def create_file_blob(filename, content_type, metadata = nil)
      ActiveStorage::Blob.create_after_upload!(
        io: file_fixture(filename).open, filename: filename, content_type: content_type, metadata: metadata
      )
    end
  end
end
