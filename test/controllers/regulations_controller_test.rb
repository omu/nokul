# frozen_string_literal: true

require 'test_helper'

class RegulationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:serhat)
    @regulation = regulations(:undergraduate)
  end

  test 'should get index' do
    get regulations_path
    assert_response :success
    assert_select '.card-header', t('regulations.index.card_header')
  end

  test 'should get show' do
    get regulation_path(@regulation)
    assert_response :success
    assert_select '.card-header', @regulation.name
    assert_select '#clauses tbody tr', @regulation.clauses.count
  end
end
