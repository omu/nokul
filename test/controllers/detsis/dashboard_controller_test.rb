# frozen_string_literal: true

require 'test_helper'

module Detsis
  class DashboardControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
    end

    test 'should get index' do
      get detsis_path

      assert_response :success
      assert_equal 'index', @controller.action_name
    end
  end
end
