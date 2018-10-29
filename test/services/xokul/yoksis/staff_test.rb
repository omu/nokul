# frozen_string_literal: true

require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  setup do
    @id_numbers = YAML.safe_load(
      Sensitive.read(
        Rails.root.join('test', 'fixtures', 'files', 'xokul_id_numbers.yml')
      )
    ).deep_symbolize_keys
  end

  test "trying to get academician's informations" do
    assert Xokul::Yoksis::Staff.academicians(
      id_number: @id_numbers[:academicians]
    )

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Staff.academicians id_number: 11_111_111_111
      Xokul::Yoksis::Staff.academicians id_number: 'id number as string'
    end
  end

  test 'trying to get nationalities' do
    assert Xokul::Yoksis::Staff.nationalities
  end

  test 'trying to get academician list' do
    assert Xokul::Yoksis::Staff.pages page: 1

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Staff.pages page: -1
      Xokul::Yoksis::Staff.pages page: 'page as string'
    end
  end
end
