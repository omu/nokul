# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

# simplecov and cobertura formatter
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/app/channels'
  add_group 'Decorators', 'app/decorators'
  add_group 'Plugins', 'plugins'
  add_group 'Policies', 'app/policies'
  add_group 'Services', 'app/services'
  add_group 'Validators', 'app/validators'
end

if ENV['CI']
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

require 'minitest/autorun'
require 'minitest/focus'
require_relative '../config/environment'
require 'rails/test_help'

require 'webmock/minitest'
WebMock.allow_net_connect!

# Test Modules
require_relative 'models/concerns/reference_test_module'

Patron::Sudo.enabled = false

module ActiveSupport
  class TestCase
    include AbstractController::Translation
    include Devise::Test::IntegrationHelpers

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    fixtures :all

    # required for controller concerns
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
