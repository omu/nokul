# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class AcademicTermsControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = {
      year: '2019 - 2020',
      term: 'spring',
      start_of_term: '2019-01-15 08:00:00'.in_time_zone,
      end_of_term: '2019-06-18 17:00:00'.in_time_zone
    }
    @update_params = {
      year: '2020 - 2021',
      term: 'summer'
    }
  end
end
