# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/references_resource_test'

class TitlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @variables = { name: 'Test title', code: '1234', branch: 'GİH' }
  end

  include ReferenceResourceTest
end
