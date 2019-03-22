# frozen_string_literal: true

require 'test_helper'

class ApplicationNameTest < ActiveSupport::TestCase
  test 'Application name can be read either from app.json or Nokul module' do
    assert_not_nil Nokul::Name.application
  end
end
