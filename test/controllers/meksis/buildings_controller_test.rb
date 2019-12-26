# frozen_string_literal: true

require 'test_helper'

module Meksis
  class BuildingsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:john)
      @building = buildings(:muhendislik_fakultesi_a_blok)
      sign_in @user
    end

    test 'should get index' do
      get meksis_buildings_path
      assert_response :success
    end

    test 'should get show' do
      get meksis_building_path(@building)
      assert_response :success
    end

    test 'should update buildings' do
      patch meksis_building_path(@building), params: {
        building: {
          latitude:  41.36442543,
          longitude: 36.18540287
        }
      }

      @building.reload

      assert_equal @building.latitude, 41.36442543
      assert_equal @building.longitude, 36.18540287
      assert_redirected_to meksis_building_path(@building)
      assert_equal translate('meksis.buildings.update.success'), flash[:notice]
    end
  end
end
