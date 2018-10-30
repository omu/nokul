# frozen_string_literal: true

require 'test_helper'

class StudentsTest < ActiveSupport::TestCase
  setup do
    @id_numbers = YAML.safe_load(
      Sensitive.read(
        Rails.root.join('test', 'fixtures', 'files', 'xokul_id_numbers.yml')
      )
    ).deep_symbolize_keys
  end

  test "trying to get student's informations" do
    assert Xokul::Yoksis::Students.informations(
      id_number: @id_numbers[:students]
    )

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Students.informations id_number: 11_111_111_111
      Xokul::Yoksis::Students.informations id_number: 'id number as string'
    end
  end
end
