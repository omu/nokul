# frozen_string_literal: true

require 'test_helper'

class LdapEntitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:john)
    @entity = ldap_entities(:one)
  end

  test 'should get index' do
    get ldap_entities_path
    assert_response :success
    assert_select '#collapseSearchLink', t('search')
  end

  test 'should get show' do
    get ldap_entity_path(@entity)
    assert_response :success
  end

  test 'should get start_sync' do
    get start_sync_ldap_entity_path(@entity)
    assert_redirected_to ldap_entity_path(@entity)
    assert_equal translate('ldap_entities.start_sync.success'), flash[:notice]
  end
end
