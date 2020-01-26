# frozen_string_literal: true

require 'test_helper'

module Detsis
  class SdpCodesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
    end

    test 'should get index' do
      get detsis_sdp_codes_path

      assert_response :success
      assert_equal 'index', @controller.action_name
      assert_select '#collapseSearch', t('smart_search')
    end
  end
end
