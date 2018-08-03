# frozen_string_literal: true

require 'test_helper'

module Accounts
  class IdentitiesController < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      sign_in @user
    end

    test 'should get index' do
      get identities_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_identity')
    end

    test 'should get new' do
      get new_identity_path
      assert_response :success
    end

    test 'should create identity' do
      @user.identities.informal.destroy_all
      assert_difference('@user.identities.count') do
        post identities_path, params: {
          identity: {
            first_name: 'Mustafa Serhat', last_name: 'Dündar', gender: :male,
            marital_status: :married, place_of_birth: cities(:samsun).id,
            date_of_birth: Time.zone.now - 20.years
          }
        }
      end

      identity = @user.identities.informal.first

      assert_equal 'Mustafa Serhat', identity.first_name
      assert_equal 'DÜNDAR', identity.last_name
      assert identity.married?
      assert identity.male?

      assert_redirected_to identities_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should not get edit for formal identity' do
      formal_identity = @user.identities.formal.first

      get edit_identity_path(formal_identity)

      assert_response :redirect
      assert_redirected_to root_path
    end

    test 'should get edit for informal identity' do
      identity = @user.identities.find_by(type: :informal)

      get edit_identity_path(identity)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update identity' do
      identity = @user.identities.find_by(type: :informal)

      patch identity_path(identity), params: {
        identity: {
          first_name: 'Test', last_name: 'Test'
        }
      }

      identity.reload

      assert_equal 'Test', identity.first_name
      assert_equal 'TEST', identity.last_name

      assert_redirected_to identities_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should not destroy for formal identity' do
      assert_difference('@user.identities.count', 0) do
        delete identity_path(@user.identities.find_by(type: :formal))
      end

      assert_redirected_to root_path
    end

    test 'should destroy for informal identity' do
      assert_difference('@user.identities.count', -1) do
        delete identity_path(@user.identities.find_by(type: :informal))
      end

      assert_redirected_to identities_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("account.identities#{key}")
    end
  end
end
