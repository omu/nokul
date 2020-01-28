# frozen_string_literal: true

require 'test_helper'

module Meksis
  class DashboardControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
    end

    test 'should get index' do
      get meksis_root_path
      assert_response :success
    end
  end
end
