# frozen_string_literal: true

require 'test_helper'

module References
  class HomeControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
    end

    test 'should get index' do
      get references_path
      assert_response :success
    end
  end
end
