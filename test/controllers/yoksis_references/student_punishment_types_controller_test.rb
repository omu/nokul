# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/references_resource_test'

class StudentPunishmentTypesControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest
end
