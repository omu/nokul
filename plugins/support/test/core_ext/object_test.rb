# frozen_string_literal: true

require 'test_helper'

class ObjectTest < ActiveSupport::TestCase
  test 'must_be_any_of! works' do
    assert_equal 13, 13.must_be_any_of!(String, Integer)
    assert_equal '13', '13'.must_be_any_of!(Integer, String)

    assert_raise(TypeError) { 13.must_be_any_of!(Symbol, String) }

    assert_equal [13, 19], [13, 19].must_be_any_of!([Integer])
    assert_equal({ x: 13, y: 19 }, { x: 13, y: 19 }.must_be_any_of!(Symbol => Integer))

    assert_raise(TypeError) { [13, '19'].must_be_any_of!([Integer]) }
    assert_raise(TypeError) { { x: 13, y: '19' }.must_be_any_of!(Symbol => Integer) }
  end
end
