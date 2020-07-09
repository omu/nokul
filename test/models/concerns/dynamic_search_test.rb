# frozen_string_literal: true

require 'test_helper'

class DynamicSearchTest < ActiveSupport::TestCase
  class DynamicSearchModel
    include DynamicSearch

    def self.init
      search_keys :foo, :bar
    end

    def self.reset
      remove_instance_variable(:@dynamic_search_keys) if defined?(@dynamic_search_keys)
    end
  end

  test 'should defined search keys for model' do
    DynamicSearchModel.init
    assert_equal DynamicSearchModel.dynamic_search_keys, %i[foo bar]
  end

  test 'search keys not defined throws an error message when raised' do
    DynamicSearchModel.reset
    exception = assert_raise(ArgumentError) { DynamicSearchModel.dynamic_search_keys }
    assert_equal 'must be defined in search_keys', exception.message
  end

  test 'dynamic search parameters should only Hash' do
    DynamicSearchModel.init

    ['Test', 5, nil].each do |parameter|
      assert_raise(ArgumentError) { DynamicSearchModel.dynamic_search(parameter) }
    end

    exception = assert_raise(ArgumentError) do
      DynamicSearchModel.dynamic_search(->(item) { puts item })
    end
    assert_equal 'parameter must be Hash', exception.message
  end

  test 'queries can be generated according to parameters' do
    DynamicSearchModel.init

    param1 = { foo: 'Test Foo', bar: '', term: 'Foo' }
    param2 = { unkown: 'Test', term: 'Foo' }
    param3 = {}
    # rubocop:disable Style/Send
    query1 = DynamicSearchModel.send(:build_query_for_dynamic_where, param1)
    query2 = DynamicSearchModel.send(:build_query_for_dynamic_where, param2)
    query3 = DynamicSearchModel.send(:build_query_for_dynamic_where, param3)
    # rubocop:enable Style/Send
    assert_equal query1, foo: 'Test Foo'
    assert_equal query2, {}
    assert_equal query3, {}
  end

  test 'should dynamic search with empty parameter for course model' do
    assert_equal Course.dynamic_search({}).count, Course.count
  end

  test 'should dynamic search only term parameter for course model' do
    courses = Course.dynamic_search(term: 'ATI101')
    assert_includes courses, courses(:ati)
    assert_not_includes courses, courses(:test)
  end

  test 'dynamic search without term parameters' do
    parameters = { unit_id: units(:omu).id, language_id: languages(:turkce).id, status: :passive }
    assert_includes Course.dynamic_search(parameters), Course.where(parameters).first
    assert_equal Course.dynamic_search(parameters).count, Course.where(parameters).count
  end

  test 'blank query returns current_scope' do
    courses    = Course.where(unit_id: units(:omu).id).order(:name)
    parameters = { unit_id: '', status: nil }
    assert_equal courses.dynamic_search(parameters), courses
  end

  test 'blank query and empty  returns all' do
    assert_equal Course.dynamic_search({}), Course.all
  end
end
