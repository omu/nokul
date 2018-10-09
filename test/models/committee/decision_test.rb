# frozen_string_literal: true

require 'test_helper'

class DecisionTest < ActiveSupport::TestCase
  setup do
    @decision = committee_decisions(:one)
  end

  # relations
  test 'decision can communicate with meeting_agenda' do
    assert @decision.meeting_agenda
  end

  # validations: presence
  %i[
    description
    decision_no
  ].each do |property|
    test "presence validations for #{property} of a decision" do
      @decision.send("#{property}=", nil)
      assert_not @decision.valid?
      assert_not_empty @decision.errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for decision_no of a desicion' do
    fake_decision = @decision.dup
    assert_not fake_decision.valid?
  end
end
