# frozen_string_literal: true

require 'test_helper'

class CodingCodeTest < ActiveSupport::TestCase
  test 'basic use case should just work' do
    code = Coding::Code.new '009'
    assert_equal '010', code.succ.to_s

    assert Coding::Code.new('013') < Coding::Code.new('020')

    range = Coding::Code.new('033')..Coding::Code.new('035')

    assert_equal '035', range.last.to_s

    assert_equal '033-034-035', range.to_a(&:to_s).join('-')
  end

  test 'implicit base-10 should work' do
    assert_equal '010', Coding::Code.new('009').succ.to_s
  end

  test 'implicit base-16 should work' do
    assert_equal '00B', Coding::Code.new('00A').succ.to_s
  end

  test 'implicit base-36 should work' do
    assert_equal '00H', Coding::Code.new('00G').succ.to_s
  end

  test 'explicit base setting should work' do
    assert_equal '0AG', Coding::Code.new('0AF', 36).succ.to_s
  end
end
