# frozen_string_literal: true

require 'test_helper'

module Meksis
  class ClassroomsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @building = buildings(:muhendislik_fakultesi_c_blok)
    end

    test 'should get index' do
      get meksis_building_classrooms_path(@building)
      assert_response :success
    end

    test 'should get show' do
      get meksis_building_classroom_path(@building, @building.classrooms.first)
      assert_response :success
    end
  end
end
