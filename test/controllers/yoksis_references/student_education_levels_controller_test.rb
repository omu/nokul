# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/references_resource_test'

class StudentEducationLevelsControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest
end
