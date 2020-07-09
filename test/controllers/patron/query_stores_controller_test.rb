# frozen_string_literal: true

require 'test_helper'

class DummyModel < ApplicationRecord
  attr_reader :name, :desc

  def self.attribute_names
    %w[name desc]
  end
end

class DummyModelScope < Patron::Scope::Base
  filter :name
  filter :desc
end

module Patron
  class QueryStoresControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @query_store = patron_query_stores(:unit_scope_muhendislik)
    end

    test 'should get index' do
      get patron_query_stores_path
      assert_response :success
      action_check('index')
      assert_select '#scopeListButton', translate('.index.new_query_store_link')
      assert_select '#collapseSmartSearchLink', t('smart_search')
    end

    test 'should get show' do
      get patron_query_store_path(@query_store)
      action_check('show')
      assert_response :success
    end

    test 'should get new' do
      get new_patron_query_store_path(scope: 'DummyModelScope')
      action_check('new')
      assert_response :success
    end

    test 'should create query store' do
      parameters = {
        name:                   'Query Store Create',
        scope_name:             'DummyModelScope',
        type:                   'inclusive',
        name_value_type:        'static',
        name_static_value:      'name created',
        name_static_query_type: 'equal',
        name_skip_empty:        'false',
        desc_value_type:        'static',
        desc_static_value:      'desc created',
        desc_static_query_type: 'equal',
        desc_skip_empty:        'false'
      }

      assert_difference('Patron::QueryStore.count') do
        post patron_query_stores_path, params: { patron_query_store: parameters }
      end

      query_store = Patron::QueryStore.last

      parameters.each do |attribute, value|
        assert_equal value, query_store.public_send(attribute)
      end

      action_check('create')
      assert_redirected_to patron_query_store_path(query_store)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_patron_query_store_path(@query_store)
      action_check('edit')
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update query store' do
      parameters = {
        name:                   'Query Store Update',
        type:                   'inclusive',
        name_value_type:        'static',
        name_static_value:      'name updated',
        name_static_query_type: 'equal',
        name_skip_empty:        'false',
        desc_value_type:        'static',
        desc_static_value:      'desc updated',
        desc_static_query_type: 'equal',
        desc_skip_empty:        'false'
      }

      query_store = Patron::QueryStore.new(scope_name: DummyModelScope)
      query_store.assign_attributes(parameters)
      query_store.save

      patch patron_query_store_path(query_store), params: { patron_query_store: parameters }

      query_store.reload

      parameters.each do |attribute, value|
        assert_equal value, query_store.public_send(attribute)
      end

      action_check('update')
      assert_redirected_to patron_query_store_path(query_store)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy query store' do
      assert_difference('Patron::QueryStore.count', -1) do
        delete patron_query_store_path(patron_query_stores(:query_store_to_delete))
      end

      assert_redirected_to patron_query_stores_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    test 'should preview query store' do
      get preview_patron_query_store_path(@query_store)
      assert_response :success
      action_check('preview')
    end

    private

    def action_check(action)
      assert_equal action, @controller.action_name
    end

    def translate(key)
      t("patron.query_stores#{key}")
    end
  end
end
