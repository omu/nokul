# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

# simplecov and codacy coverage
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/app/channels'
end

require 'codacy-coverage' if ENV['CI']
Codacy::Reporter.start if ENV['CI']

require 'minitest/autorun'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

module ActiveSupport
  class TestCase
    include AbstractController::Translation
    include Devise::Test::IntegrationHelpers
    include Capybara::DSL
    include Capybara::Minitest::Assertions

    fixtures :all

    def controller_name
      @controller_name ||= class_name.delete_suffix('ControllerTest').underscore
    end

    def create_file_blob(filename, content_type, metadata = nil)
      ActiveStorage::Blob.create_after_upload!(
        io: file_fixture(filename).open, filename: filename, content_type: content_type, metadata: metadata
      )
    end

    SUPPORTED_SCREEN_RESOLUTIONS = [
      [360,   640],
      [1024,  768],
      [1366,  768],
      [1920, 1080]
    ].freeze

    # Switch to :selenium_chrome for real-time browser experience.
    Capybara.default_driver = :selenium_chrome_headless
    Capybara.server = :puma, { Silent: true }

    def teardown
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end
