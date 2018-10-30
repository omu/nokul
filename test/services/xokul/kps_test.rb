# frozen_string_literal: true

require 'test_helper'

class KpsTest < ActiveSupport::TestCase
  IDENTITY_TEST_ID_NUMBERS = [
    10_570_898_198,
    10_114_899_148,
    10_555_885_052,
    99_001_255_472,
    99_031_254_452,
    99_007_254_028,
    10_026_078_778,
    14_203_772_848,
    10_197_025_724
  ].freeze

  test 'trying to get personal informations' do
    IDENTITY_TEST_ID_NUMBERS.each do |id_number|
      assert Xokul::Kps::Identity.new id_number
    end

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Kps::Identity.new 11_111_111_111
      Xokul::Kps::Identity.new 'id number as string'
    end
  end

  test 'trying to get address informations' do
    assert Xokul::Kps::Address.new 10_114_899_148

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Kps::Address.new 11_111_111_111
      Xokul::Kps::Address.new 'id number as string'
    end
  end

  test 'trying to verify personal informations' do
    response = Xokul::Kps.verify_identity(
      id_number:     11_111_111_111,
      first_name:    'first name',
      last_name:     'last name',
      year_of_birth: 1999
    )

    assert_equal response[:status], false

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Kps.verify_identity(
        id_number:     'id number as string',
        first_name:    'foo',
        last_name:     'bar',
        year_of_birth: -1
      )
    end
  end
end
