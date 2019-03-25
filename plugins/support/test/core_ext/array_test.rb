# frozen_string_literal: true

require 'test_helper'

class ArrayTest < ActiveSupport::TestCase
  test 'clip works' do
    assert_equal %w[foo bar], %w[foo bar baz quux].clip(2)
  end

  test 'join_affixed works' do
    assert_equal 'aaa.foo-bar-baz-quux_zzz',
                 %w[foo bar baz quux].join_affixed(prefix: 'aaa.', interfix: '-', suffix: '_zzz')
  end
end
