# frozen_string_literal: true

require 'test_helper'

module Accounts
  class AddressesController < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      @user.addresses.informal.create(
        phone_number: '03623121919', full_address: 'OMÜ BAUM', district_id: districts(:gerze).id
      )
      sign_in @user
    end

    test 'should get index' do
      get user_addresses_path(@user)
      assert_response :success
    end

    test 'should get new' do
      get new_user_address_path(@user)
      assert_response :success
    end

    test 'should create address' do
      @user.addresses.informal.destroy_all
      assert_difference('@user.addresses.count') do
        post user_addresses_path(@user), params: {
          address: {
            phone_number: '03623121919', full_address: 'OMÜ BAUM', district_id: districts(:gerze).id
          }
        }
      end

      address = @user.addresses.find_by(type: :informal)

      assert_equal '03623121919', address.phone_number
      assert_equal 'OMÜ BAUM', address.full_address
      assert_equal districts(:gerze), address.district

      assert_redirected_to user_addresses_path(@user)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should not get edit for formal address' do
      formal_address = @user.addresses.find_by(type: :formal)

      get edit_user_address_path(@user, formal_address)
      assert_response :redirect
      assert_redirected_to root_path
    end

    test 'should get edit for any address except formal' do
      address = @user.addresses.where(type: :informal).first

      get edit_user_address_path(@user, address)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update address' do
      address = @user.addresses.informal.first

      patch user_address_path(@user, address), params: {
        address: {
          phone_number: '03623121920', full_address: 'OMÜ UZEM'
        }
      }

      address.reload

      assert_equal '03623121920', address.phone_number
      assert_equal 'OMÜ UZEM', address.full_address

      assert_redirected_to user_addresses_path(@user)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should be able to fetch address from mernis' do
      get save_from_mernis_user_addresses_path(@user)
      assert_redirected_to user_path(@user)
    end

    test 'should not destroy for formal address' do
      assert_difference('@user.addresses.count', 0) do
        delete user_address_path(@user, @user.addresses.formal)
      end

      assert_redirected_to root_path
    end

    test 'should destroy for any address except formal' do
      assert_difference('@user.addresses.count', -1) do
        delete user_address_path(@user, @user.addresses.where.not(type: :formal).first)
      end

      assert_redirected_to user_addresses_path(@user)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("account.addresses#{key}")
    end
  end
end
