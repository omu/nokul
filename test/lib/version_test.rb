# frozen_string_literal: true

require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  test 'Application version can be read either from app.json or Nokul module' do
    assert_not_nil Nokul::Version.current
  end
end
