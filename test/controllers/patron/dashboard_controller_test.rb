# frozen_string_literal: true

require 'test_helper'

module Patron
  class DashboardControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
    end

    test 'should get index' do
      get patron_path
      assert_response :success
      assert_equal 'index', @controller.action_name
    end
  end
end
