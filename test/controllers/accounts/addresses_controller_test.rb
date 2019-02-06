# frozen_string_literal: true

require 'test_helper'

module Accounts
  class AddressesController < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      @user.addresses.informal.create(
        phone_number: '05554443322',
        full_address: 'OMÜ BAUM',
        district_id: districts(:gerze).id,
        country: 'tr'
      )
      @form_params = %w[phone_number full_address district_id country]
      sign_in @user
    end

    test 'should be able to get index path' do
      get addresses_path
      assert_response :success
    end

    test 'should be able to get /new when there is no informal address' do
      @user.addresses.informal.destroy_all
      get new_address_path
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#address_#{param}"
        end
      end
    end

    test 'should be able to create an informal address' do
      @user.addresses.informal.destroy_all
      assert_difference('@user.addresses.informal.count') do
        post addresses_path, params: {
          address: {
            phone_number: '05554443322',
            full_address: 'OMÜ BAUM',
            district_id: districts(:gerze).id,
            country: 'tr'
          }
        }
      end

      address = @user.addresses.find_by(type: :informal)

      assert_equal '05554443322', address.phone_number
      assert_equal 'OMÜ BAUM', address.full_address
      assert_equal districts(:gerze), address.district

      assert_redirected_to addresses_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should not be able to get /new when there is an informal address' do
      get new_address_path
      assert_response :redirect
      assert_redirected_to addresses_path
    end

    test 'should not be able to get /edit for a formal address' do
      formal_address = @user.addresses.find_by(type: :formal)

      get edit_address_path(formal_address)
      assert_response :redirect
      assert_redirected_to root_path
    end

    test 'should be able to get /edit for an informal addresses' do
      address = @user.addresses.where(type: :informal).first

      get edit_address_path(address)
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#address_#{param}"
        end
      end
    end

    test 'should be able to update an informal address' do
      address = @user.addresses.informal.first

      patch address_path(address), params: {
        address: {
          phone_number: '05554443322', full_address: 'OMÜ UZEM', country: 'tr'
        }
      }

      address.reload

      assert_equal '05554443322', address.phone_number
      assert_equal 'OMÜ UZEM', address.full_address

      assert_redirected_to addresses_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should be able to create/update a formal address from mernis' do
      get save_from_mernis_addresses_path
      assert_redirected_to addresses_path
    end

    test 'should be able to destroy an informal address' do
      assert_difference('@user.addresses.informal.count', -1) do
        delete address_path(@user.addresses.informal.first)
      end

      assert_redirected_to addresses_path
    end

    test 'should not be able to destroy a formal address' do
      assert_difference('@user.addresses.informal.count', 0) do
        delete address_path(@user.addresses.formal)
      end

      assert_redirected_to root_path
    end

    private

    def translate(key)
      t("account.addresses#{key}")
    end
  end
end
