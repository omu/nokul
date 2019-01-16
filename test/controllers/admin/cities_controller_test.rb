# frozen_string_literal: true

require 'test_helper'

module Admin
  class CitiesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @country = countries(:turkey)
      @city = cities(:samsun)
      @form_params = %w[name alpha_2_code]
    end

    test 'should get show' do
      get admin_country_city_path(@country, @city)
      assert_equal 'show', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.show.new_district_link')
    end

    test 'should get new' do
      get new_admin_country_city_path(@country)
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#city_#{param}"
        end
      end
    end

    test 'should create city' do
      assert_difference('City.count') do
        post admin_country_cities_path(@country), params: {
          city: { name: 'Test City', alpha_2_code: 'TR-90' }
        }
      end

      assert_equal 'create', @controller.action_name

      city = City.last

      assert_equal 'Test City', city.name
      assert_equal 'TR-90', city.alpha_2_code
      assert_redirected_to admin_country_city_path(@country, city)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_admin_country_city_path(@country, @city)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#city_#{param}"
        end
      end
    end

    test 'should update city' do
      city = City.last
      patch admin_country_city_path(@country, city), params: {
        city: { name: 'Test City Update', alpha_2_code: 'TR-91' }
      }

      assert_equal 'update', @controller.action_name

      city.reload

      assert_equal 'Test City Update', city.name
      assert_equal 'TR-91', city.alpha_2_code
      assert_redirected_to admin_country_city_path(@country, city)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy city' do
      assert_difference('City.count', -1) do
        delete admin_country_city_path(@country, cities(:adana))
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to admin_country_path(@country)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("admin.cities#{key}")
    end
  end
end
