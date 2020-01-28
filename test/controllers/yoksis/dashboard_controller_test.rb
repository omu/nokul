# frozen_string_literal: true

require 'test_helper'

module Yoksis
  class DashboardControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
    end

    test 'should get index' do
      get yoksis_root_path
      assert_equal 'index', @controller.action_name
      assert_response :success
    end
  end
end
