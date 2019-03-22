# frozen_string_literal: true

require 'test_helper'

module Location
  class CountriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @country = countries(:turkey)
      @form_params = %w[name alpha_2_code alpha_3_code numeric_code mernis_code yoksis_code]
    end

    test 'should get index' do
      get countries_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_country_link')
    end

    test 'should get show' do
      get country_path(@country)
      assert_equal 'show', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.show.new_city_link')
    end

    test 'should get new' do
      get new_country_path

      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#country_#{param}"
        end
      end
    end

    test 'should create country' do
      assert_difference('Country.count') do
        post countries_path, params: {
          country: {
            name: 'Test Country', alpha_2_code: 'WW', alpha_3_code: 'WWW', numeric_code: '999',
            mernis_code: '9999', yoksis_code: '30001', continent: 'Avrupa', currency_code: 'XYZ',
            world_region: 'EMEA', latitude: 0, longitude: 0
          }
        }
      end

      assert_equal 'create', @controller.action_name

      country = Country.last

      assert_equal 'Test Country', country.name
      assert_equal 'WW', country.alpha_2_code
      assert_equal 'WWW', country.alpha_3_code
      assert_equal '999', country.numeric_code
      assert_equal '9999', country.mernis_code
      assert_equal 30_001, country.yoksis_code
      assert_equal 'Avrupa', country.continent
      assert_equal 'XYZ', country.currency_code
      assert_equal 'EMEA', country.world_region
      assert_redirected_to country_path(country)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_country_path(@country)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#country_#{param}"
        end
      end
    end

    test 'should update country' do
      country = Country.last
      patch country_path(country), params: {
        country: {
          name: 'Test Country Update', alpha_2_code: 'TT', alpha_3_code: 'TCT',
          numeric_code: '998', mernis_code: '9998', yoksis_code: '30002'
        }
      }

      assert_equal 'update', @controller.action_name

      country.reload

      assert_equal 'Test Country Update', country.name
      assert_equal 'TT', country.alpha_2_code
      assert_equal 'TCT', country.alpha_3_code
      assert_equal '998', country.numeric_code
      assert_equal '9998', country.mernis_code
      assert_equal 30_002, country.yoksis_code
      assert_redirected_to country_path(country)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy country' do
      assert_difference('Country.count', -1) do
        delete country_path(countries(:norway))
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to countries_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("location.countries#{key}")
    end
  end
end
