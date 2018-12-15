# frozen_string_literal: true

require 'test_helper'

module References
  class CitiesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @country = countries(:turkey)
      @city = cities(:samsun)
    end

    test 'should get show' do
      get country_city_path(@country, @city)
      assert_response :success
      assert_select '#add-button', translate('.show.new_district_link')
    end

    test 'should get new' do
      get new_country_city_path(@country)
      assert_response :success
    end

    test 'should create city' do
      assert_difference('City.count') do
        post country_cities_path(@country), params: {
          city: { name: 'Test City', alpha_2_code: 'TR-90' }
        }
      end

      city = City.last

      assert_equal 'Test City', city.name
      assert_equal 'TR-90', city.alpha_2_code
      assert_redirected_to country_city_path(@country, city)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_country_city_path(@country, @city)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update city' do
      city = City.last
      patch country_city_path(@country, city), params: {
        city: { name: 'Test City Update', alpha_2_code: 'TR-91' }
      }

      city.reload

      assert_equal 'Test City Update', city.name
      assert_equal 'TR-91', city.alpha_2_code
      assert_redirected_to country_city_path(@country, city)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy city' do
      assert_difference('City.count', -1) do
        delete country_city_path(@country, cities(:adana))
      end

      assert_redirected_to country_path(@country)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("references.cities#{key}")
    end
  end
end
