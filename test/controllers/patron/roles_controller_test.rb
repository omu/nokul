# frozen_string_literal: true

require 'test_helper'

module Patron
  class RolesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @role = patron_roles(:admin)
    end

    test 'should get index' do
      get patron_roles_path
      assert_response :success
      action_check('index')
      assert_select '#add-button', translate('.index.new_role_link')
      assert_select '#collapseSmartSearchLink', t('smart_search')
    end

    test 'should get show' do
      get patron_role_path(@role)
      action_check('show')
      assert_response :success
    end

    test 'should get new' do
      get new_patron_role_path
      action_check('new')
      assert_response :success
    end

    test 'should create role' do
      parameters = {
        name:           'Role Create',
        identifier:     'role_create',
        permission_ids: Permission.pluck(:id).sort
      }

      assert_difference('Patron::Role.count') do
        post patron_roles_path, params: { patron_role: parameters }
      end

      role = Patron::Role.last

      assert_equal parameters[:name],           role.name
      assert_equal parameters[:identifier],     role.identifier
      assert_equal parameters[:permission_ids], role.permission_ids.sort
      action_check('create')
      assert_redirected_to patron_role_path(role)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_patron_role_path(patron_roles(:role_to_update))
      action_check('edit')
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update role' do
      role = patron_roles(:role_to_update)

      parameters = {
        name:           'Role Update',
        identifier:     'role_update',
        permission_ids: Patron::Permission.pluck(:id).sort
      }
      patch patron_role_path(role), params: { patron_role: parameters }

      role.reload

      assert_equal parameters[:name],           role.name
      assert_equal parameters[:identifier],     role.identifier
      assert_equal parameters[:permission_ids], role.permission_ids.sort
      action_check('update')
      assert_redirected_to patron_role_path(role)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy role' do
      assert_difference('Patron::Role.count', -1) do
        delete patron_role_path(patron_roles(:role_to_delete))
      end

      assert_redirected_to patron_roles_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def action_check(action)
      assert_equal action, @controller.action_name
    end

    def translate(key)
      t("patron.roles#{key}")
    end
  end
end
