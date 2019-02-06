# frozen_string_literal: true

require 'test_helper'

module UserManagement
  class AddressesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @serhat = users(:serhat)
      @john = users(:john)
      @john.addresses.informal.create(
        phone_number: '05554443322',
        full_address: 'OMÜ BAUM',
        district_id: districts(:gerze).id,
        country: 'tr'
      )
      @form_params = %w[district_id country phone_number full_address]
      sign_in @serhat
    end

    test 'should be able to get index path' do
      get user_management_users_path
      assert_response :success
    end

    test 'should be able to get /new when there is no informal address' do
      @john.addresses.informal.destroy_all
      get new_user_management_user_address_path(@john)
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#address_#{param}"
        end
      end
    end

    test 'should be able to create an informal address' do
      @john.addresses.informal.destroy_all
      assert_difference('@john.addresses.informal.count') do
        post user_management_user_addresses_path(@john), params: {
          address: {
            phone_number: '05554443322',
            full_address: 'OMÜ BAUM',
            district_id: districts(:gerze).id,
            country: 'tr'
          }
        }
      end

      address = @john.addresses.find_by(type: :informal)

      assert_equal '05554443322', address.phone_number
      assert_equal 'OMÜ BAUM', address.full_address
      assert_equal districts(:gerze), address.district

      assert_redirected_to user_management_user_addresses_path(@john)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should not be able to get /new when there is an informal address' do
      get new_user_management_user_address_path(@john)
      assert_response :redirect
      assert_redirected_to user_management_user_addresses_path(@john)
    end

    test 'should not be able to get /edit for a formal address' do
      formal_address = @john.addresses.find_by(type: :formal)

      get edit_user_management_user_address_path(@john, formal_address)
      assert_response :redirect
      assert_redirected_to root_path
    end

    test 'should be able to update an informal address' do
      address = @john.addresses.informal.first

      patch user_management_user_address_path(@john, address), params: {
        address: {
          phone_number: '05554443322', full_address: 'OMÜ UZEM', country: 'tr'
        }
      }

      address.reload

      assert_equal '05554443322', address.phone_number
      assert_equal 'OMÜ UZEM', address.full_address

      assert_redirected_to user_management_user_addresses_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    # test 'should be able to create/update a formal address from mernis' do
    #   get save_from_mernis_user_management_user_addresses_path(@john.addresses.formal)
    #   assert_redirected_to user_management_user_addresses_path(@john)
    # end

    # test 'should be able to destroy an informal address' do
    #   assert_difference('@user.addresses.informal.count', -1) do
    #     delete address_path(@user.addresses.informal.first)
    #   end

    #   assert_redirected_to addresses_path
    # end

    # test 'should not be able to destroy a formal address' do
    #   assert_difference('@user.addresses.informal.count', 0) do
    #     delete address_path(@user.addresses.formal)
    #   end

    #   assert_redirected_to root_path
    # end

    private

    def translate(key)
      t("user_management.addresses#{key}")
    end
  end
end
