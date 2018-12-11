require 'test_helper'

class TermTest < ActiveSupport::TestCase
  setup do
    @term = terms(:fall)
  end

  # validations: presence
  %i[
    name
    identifier
  ].each do |property|
    test "presence validations for #{property} of a term" do
      @term.send("#{property}=", nil)
      assert_not @term.valid?
      assert_not_empty @term.errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    identifier
  ].each do |property|
    test "uniqueness validations for #{property} of a term" do
      fake = @term.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # callbacks
  test 'callbacks must titlecase the name of a term' do
    term = Term.create!(name: 'Test tErm', identifier: 'test')
    assert_equal term.name, 'Test Term'
  end
end
