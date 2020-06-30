# frozen_string_literal: true

require 'test_helper'

module Committee
  class DashboardControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
    end

    test 'should get index' do
      get committees_path
      assert_response :success
      assert_select 'table thead th', translate('.index.name')
    end

    private

    def translate(key)
      t("committee.dashboard#{key}")
    end
  end
end
