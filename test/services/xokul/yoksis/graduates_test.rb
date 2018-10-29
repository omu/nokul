# frozen_string_literal: true

require 'test_helper'

class GraduatesTest < ActiveSupport::TestCase
  setup do
    @id_numbers = YAML.safe_load(
      Sensitive.read(
        Rails.root.join('test', 'fixtures', 'files', 'xokul_id_numbers.yml')
      )
    ).deep_symbolize_keys
  end

  test "trying to get someone's college graduation informations" do
    assert Xokul::Yoksis::Graduates.informations(
      id_number: @id_numbers[:graduates]
    )

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Graduates.informations id_number: 11_111_111_111
      Xokul::Yoksis::Graduates.informations id_number: 'id number as string'
    end
  end
end
