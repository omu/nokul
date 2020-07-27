# frozen_string_literal: true

require 'test_helper'

class ArelTest < ActiveSupport::TestCase
  PREDICATES_FOR_ARRAY    = %i[in not_in].freeze
  PREDICATES_FOR_STRING   = %i[equal not_equal greater_than greater_than_to_equal less_than less_than_to_equal].freeze
  PREDICATES_FOR_SQL_LIKE = %i[start_with not_start_with end_with not_end_with contain not_contain].freeze
  EQUIVALENTS             = {
    equal:                 :eq,
    not_equal:             :not_eq,
    greater_than:          :gt,
    greater_than_to_equal: :gteq,
    less_than:             :lt,
    less_than_to_equal:    :lteq,
    start_with:            :matches,
    not_start_with:        :does_not_match,
    end_with:              :matches,
    not_end_with:          :does_not_match,
    contain:               :matches,
    not_contain:           :does_not_match
  }.freeze

  setup do
    @arel = Patron::Scope::Query::Arel
  end

  [
    *PREDICATES_FOR_ARRAY,
    *PREDICATES_FOR_STRING,
    *PREDICATES_FOR_SQL_LIKE
  ].each do |predicate|
    test "predicate is available for #{predicate}" do
      assert @arel.predicates.key?(predicate)
    end
  end

  EQUIVALENTS.each do |predicate, equivalent|
    test "equivalent of #{predicate} is #{equivalent}" do
      assert_equal equivalent, @arel.predicates.dig(predicate, :equivalent_to)
    end
  end

  test 'predicates_for_array method' do
    assert_equal @arel.predicates_for_array, PREDICATES_FOR_ARRAY
  end

  test 'predicates_for_string method' do
    assert_equal @arel.predicates_for_string, PREDICATES_FOR_STRING | PREDICATES_FOR_SQL_LIKE
  end

  test 'predicates_for_sql_like method' do
    assert_equal @arel.predicates_for_sql_like, PREDICATES_FOR_SQL_LIKE
  end

  test 'filter_predicates_by_scope method' do
    assert_equal @arel.filter_predicates_by_scope(:array, :like).keys,
                 PREDICATES_FOR_ARRAY | PREDICATES_FOR_SQL_LIKE
  end

  test 'sanitize method' do
    assert_equal('100\\%', @arel.sanitize(:contain, '100%'))
  end

  test 'format method' do
    assert_equal 'test%',        @arel.format('test', suffix: '%')
    assert_equal '%test',        @arel.format('test', prefix: '%')
    assert_equal '%test%',       @arel.format('test', suffix: '%', prefix: '%')
    assert_equal ['%a%', '%b%'], @arel.format(%w[a b], suffix: '%', prefix: '%')
  end
end
