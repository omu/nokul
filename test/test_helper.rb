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

module MiniTest
  # Support methods
  module Support
    module_function

    # :reek:NestedIterators
    def array_to_hash(array)
      array.each_with_object({}) do |element, hash|
        hash[element] ||= array.select { |item| item == element }.size
      end
    end
  end

  # Extra assertions
  module Assertions
    # Stolen and heavily refactored from minitest-rails-shoulda
    # Copyright (c) 2012-2013 Robert Bousquet, Rafal Wrzochol
    # MIT License

    # :reek:NestedIterators :reek:TooManyStatements { max_statements: 6 }
    def assert_same_elements(left, right, message = nil)
      %i[select inject size].each do |method|
        [left, right].each do |array|
          assert_respond_to(array, method,
                            "Are you sure that #{array.inspect} is an array?  It doesn't respond to #{method}.")
        end
      end

      assert left_hash  = Support.array_to_hash(left)
      assert right_hash = Support.array_to_hash(right)

      assert_equal(left_hash, right_hash, message)
    end
  end
end
