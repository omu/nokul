# frozen_string_literal: true

require 'test_helper'

class DuplicateServiceTest < ActiveSupport::TestCase
  test 'can create duplicates of a record by adding a prefix' do
    @duplicate_record = DuplicateService.new(cities(:samsun), 'name').duplicate
    assert @duplicate_record.name.starts_with?('[kopyası]')
  end
end
