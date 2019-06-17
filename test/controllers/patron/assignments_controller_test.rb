# frozen_string_literal: true

require 'test_helper'

module Patron
  class AssignmentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @user = users(:mine)
    end

    test 'should get index' do
      get patron_assignments_path
      assert_response :success
      action_check('index')
    end

    test 'should get show' do
      get patron_assignment_path(@user)
      action_check('show')
      assert_response :success
    end

    test 'should get edit' do
      get edit_patron_assignment_path(@user)
      action_check('edit')
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update role' do
      parameters = {
        role_ids:        [patron_roles(:admin).id],
        query_store_ids: [patron_query_stores(:unit_scope_egitim).id]
      }
      patch patron_assignment_path(@user), params: { user: parameters }

      @user.reload

      parameters.each do |attribute, value|
        assert_equal value, @user.send(attribute)
      end
      action_check('update')
      assert_redirected_to patron_assignment_path(@user)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should get preview_scope' do
      get preview_scope_patron_assignment_path(
        users(:serhat), scope: users(:serhat).query_stores.first&.scope_name
      )
      action_check('preview_scope')
      assert_response :success
    end

    private

    def action_check(action)
      assert_equal action, @controller.action_name
    end

    def translate(key)
      t("patron.assignments#{key}")
    end
  end
end
