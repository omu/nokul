# frozen_string_literal: true

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  setup do
    @document = documents(:health_report)
  end

  # validations: presence
  test 'presence validations for name of a document' do
    @document.update(name: nil)
    assert_not @document.valid?
    assert_not_empty @document.errors[:name]
  end

  # validations: uniqueness
  test 'uniqueness validations for name of a document' do
    fake = @document.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end
end
