# frozen_string_literal: true

require 'test_helper'

module Locations
  class CountriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @country = countries(:turkey)
    end

    test 'should get index' do
      get countries_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_country_link')
    end

    test 'should get show' do
      get country_path(@country)
      assert_response :success
      assert_select '#add-button', translate('.show.new_city_link')
    end

    test 'should get new' do
      get new_country_path
      assert_response :success
    end

    test 'should create country' do
      assert_difference('Country.count') do
        post countries_path params: {
          country: {
            name: 'Test Country', alpha_2_code: 'TC', alpha_3_code: 'TCC',
            numeric_code: '10001', mernis_code: '20001'
          }
        }
      end

      country = Country.last

      assert_equal 'Test Country', country.name
      assert_equal 'TC', country.alpha_2_code
      assert_equal 'TCC', country.alpha_3_code
      assert_equal '10001', country.numeric_code
      assert_equal '20001', country.mernis_code
      assert_redirected_to country_path(country)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_country_path(@country)
      assert_response :success

      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update country' do
      country = Country.last
      patch country_path(country), params: {
        country: {
          name: 'Test Country Update', alpha_2_code: 'TCU', alpha_3_code: 'TCCU',
          numeric_code: '10002', mernis_code: '20002'
        }
      }

      country.reload

      assert_equal 'Test Country Update', country.name
      assert_equal 'TCU', country.alpha_2_code
      assert_equal 'TCCU', country.alpha_3_code
      assert_equal '10002', country.numeric_code
      assert_equal '20002', country.mernis_code
      assert_redirected_to country_path(country)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy country' do
      assert_difference('Country.count', -1) do
        delete country_path(Country.last)
      end

      assert_redirected_to countries_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("locations.countries#{key}")
    end
  end
end
