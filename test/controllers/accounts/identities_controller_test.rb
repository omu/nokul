# frozen_string_literal: true

require 'test_helper'

module Accounts
  class IdentitiesController < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      @user.identities.informal.create(
        first_name: 'Mustafa Serhat',
        last_name: 'Dündar',
        gender: :male,
        marital_status: :married,
        place_of_birth: cities(:samsun).id,
        date_of_birth: Time.zone.now - 20.years
      )

      @form_params = %w[
        first_name last_name mothers_name fathers_name gender marital_status place_of_birth registered_to
        date_of_birth_1i date_of_birth_2i date_of_birth_3i
      ]
      sign_in @user
    end

    test 'should be able to get index path' do
      get identities_path
      assert_response :success
    end

    test 'should not be able to get /new when there is a formal identity' do
      @user.identities.informal.destroy_all
      get new_identity_path
      assert_response :redirect
      assert_redirected_to identities_path
    end

    test 'should not be able to create an informal identity when there is a formal identity' do
      @user.identities.informal.destroy_all
      assert_no_difference('@user.identities.count') do
        post identities_path(@user), params: {
          identity: {
            first_name: 'Mustafa Serhat', last_name: 'Dündar', gender: :male,
            marital_status: :married, place_of_birth: cities(:samsun).id,
            date_of_birth: Time.zone.now - 20.years
          }
        }
      end
      assert_response :redirect
      assert_redirected_to identities_path
    end

    test 'should not be able to get /edit for a formal identity' do
      formal_identity = @user.identities.formal.first

      get edit_identity_path(formal_identity)

      assert_response :redirect
      assert_redirected_to root_path
    end

    test 'should be able to get /edit for a informal identity' do
      identity = @user.identities.find_by(type: :informal)

      get edit_identity_path(identity)
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#identity_#{param}"
        end
      end
    end

    test 'should be able to update an informal identity' do
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

    test 'should not be able to update a formal identity' do
      identity = @user.identities.find_by(type: :formal)

      patch identity_path(identity), params: {
        identity: {
          first_name: 'Test', last_name: 'Test'
        }
      }

      assert_redirected_to root_path
      assert_response :redirect
    end

    test 'should be able to fetch identity from mernis' do
      get save_from_mernis_identities_path
      assert_redirected_to identities_path
    end

    test 'should not be able to destroy a formal identity' do
      assert_difference('@user.identities.count', 0) do
        delete identity_path(@user.identities.find_by(type: :formal))
      end

      assert_redirected_to root_path
    end

    test 'should be able to destroy an informal identity' do
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
