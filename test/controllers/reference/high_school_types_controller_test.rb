# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class HighSchoolTypesControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest
end
