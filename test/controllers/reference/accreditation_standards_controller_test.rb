# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class AccreditationStandardsControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = { name: 'MİAK' }
    @update_params = { name: 'EPDAD' }
  end
end
