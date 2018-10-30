# frozen_string_literal: true

require 'test_helper'

class MebTest < ActiveSupport::TestCase
  setup do
    @id_numbers = YAML.safe_load(
      Sensitive.read(
        Rails.root.join('test', 'fixtures', 'files', 'xokul_id_numbers.yml')
      )
    ).deep_symbolize_keys
  end

  test "trying to get someone's student informations from MEB" do
    assert Xokul::Yoksis::Meb.students(
      id_number: @id_numbers[:meb]
    )

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Meb.students id_number: 11_111_111_111
      Xokul::Yoksis::Meb.students id_number: 'id number as string'
    end
  end
end
