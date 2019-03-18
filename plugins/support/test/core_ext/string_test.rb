# frozen_string_literal: true

require 'test_helper'

class StringTest < ActiveSupport::TestCase
  test 'affixed works' do
    assert_equal 'aaa.foo bar baz quux_zzz', 'foo bar baz quux'.affixed(prefix: 'aaa.', interfix: '-', suffix: '_zzz')
  end

  test 'inside_offensives? works' do
    assert 'salak'.inside_offensives?
    assert 'manyak'.inside_offensives?
  end

  test 'inside_reserved? works' do
    assert 'while'.inside_reserved?
    assert 'end'.inside_reserved?
  end

  test 'inside_abbreviations? works' do
    assert 'yök'.inside_abbreviations?
    assert 'kktc'.inside_abbreviations?
  end

  test 'inside_conjunctions? works' do
    assert 've'.inside_conjunctions?
    assert 'veya'.inside_conjunctions?
  end
end
