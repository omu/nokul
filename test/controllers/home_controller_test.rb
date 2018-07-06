# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:john)
  end

  test 'should get index' do
    get root_path
    assert_response :success
  end
end
