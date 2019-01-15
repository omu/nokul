# frozen_string_literal: true

require 'test_helper'

class EvaluationTypeTest < ActiveSupport::TestCase
  # validations: presence
  test 'presence validations for name of a evaluation type' do
    evaluation_type = evaluation_types(:undergraduate_midterm)
    evaluation_type.name = nil
    assert_not evaluation_type.valid?
    assert_not_empty evaluation_type.errors[:name]
  end
end
