# frozen_string_literal: true

require 'test_helper'

class CodificationTest < ActiveSupport::TestCase
  test 'Codification API exists' do
    assert defined? Codification
    assert(%i[Unit User Student].all? { |mod| Codification.const_defined?(mod) })
  end

  test 'Codification API has proper methods' do
    assert_respond_to Codification::User, :name_generate
    assert_respond_to Codification::User, :name_suggest

    assert_respond_to Codification::Student, :short_number_generator
    assert_respond_to Codification::Student, :long_number_generator

    assert_respond_to Codification::Unit, :code_generator
  end
end
