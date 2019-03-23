# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/yoksis_resource_test'

class UnitTypesControllerTest < ActionDispatch::IntegrationTest
  include YoksisResourceTest
end
