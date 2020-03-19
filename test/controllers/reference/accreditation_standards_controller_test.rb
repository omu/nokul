# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class AccreditationStandardsControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = { name: 'MİAK', version: '1' }
    @update_params = { name: 'EPDAD', version: '1' }
  end
end
