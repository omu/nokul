# frozen_string_literal: true

require 'test_helper'

module Patron
  class PermissionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
    end

    test 'should get index' do
      get patron_permissions_path
      assert_response :success
      action_check('index')
      assert_select '#collapseSmartSearchLink', t('smart_search')
    end

    test 'should get show' do
      get patron_permission_path(patron_permissions(:course_management))
      action_check('show')
      assert_response :success
    end

    private

    def action_check(action)
      assert_equal action, @controller.action_name
    end

    def translate(key)
      t("patron.permissions#{key}")
    end
  end
end
