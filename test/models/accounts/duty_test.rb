# frozen_string_literal: true

require 'test_helper'

class DutyTest < ActiveSupport::TestCase
  setup do
    @duties = employees(:serhat_active).duties
  end

  # relations
  %i[
    employee
    unit
    positions
    administrative_functions
  ].each do |property|
    test "a duty can communicate with #{property}" do
      assert duties(:baum).send(property)
    end
  end

  # validations: presence
  %i[
    temporary
    start_date
  ].each do |property|
    test "presence validations for #{property} of a duty" do
      duties(:baum).send("#{property}=", nil)
      assert_not duties(:baum).valid?
      assert_not_empty duties(:baum).errors[property]
    end
  end

  # validations: uniqueness
  test 'duplication validations for unit' do
    fake = duties(:baum).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:unit_id]
  end

  # duty validator
  test 'a user can only have one active tenure duty' do
    fake = duties(:omu).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:base]
    assert fake.errors[:base].include?(I18n.t('validators.duty.active_and_tenure'))
  end

  # scopes
  test 'temporary scope returns temporary duties' do
    assert @duties.temporary.to_a.include?(duties(:uzem))
    assert_not @duties.temporary.to_a.include?(duties(:omu))
  end

  test 'tenure scope returns tenure duties' do
    assert @duties.tenure.to_a.include?(duties(:omu))
    assert_not @duties.tenure.to_a.include?(duties(:uzem))
  end

  test 'active scope returns active duties' do
    assert @duties.active.to_a.include?(duties(:omu))
    assert_not @duties.active.to_a.include?(duties(:uzem))
  end

  # custom tests
  test 'active? returns if an instance is active or not' do
    assert duties(:omu).active?
    assert duties(:baum).active?
    assert_not duties(:uzem).active?
  end
end
