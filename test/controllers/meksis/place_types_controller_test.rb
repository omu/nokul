# frozen_string_literal: true

require 'test_helper'

module Meksis
  class PlaceTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
    end

    test 'should get index' do
      get meksis_place_types_path
      assert_response :success
    end

    test 'should get show' do
      get meksis_place_type_path(place_types(:egitim))
      assert_response :success
    end
  end
end
