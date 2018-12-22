# frozen_string_literal: true

require 'test_helper'

module Admin
  class HomeControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
    end

    test 'should get index' do
      get admin_yoksis_path
      assert_response :success
    end
  end
end
