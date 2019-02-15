# frozen_string_literal: true

require 'test_helper'

class DutyTest < ActiveSupport::TestCase
  include AssociationTestModule

  setup do
    @duties = employees(:serhat_active).duties
  end

  # relations
  belongs_to :employee
  belongs_to :unit
  has_many :positions
  has_many :administrative_functions

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
  test 'start date can not be after end date' do
    fake = duties(:uzem).dup
    fake.update(end_date: fake.start_date - 1.year)
    assert_not fake.valid?
    assert_not_empty fake.errors[:end_date]
    assert fake.errors[:end_date].include?(t('validators.duty.invalid_end_date'))
  end

  test 'a user can only have one active tenure duty' do
    tenure = duties(:omu).dup
    assert_not tenure.valid?
    assert_not_empty tenure.errors[:base]
    assert tenure.errors[:base].include?(t('validators.duty.active_and_tenure'))
  end

  test 'a user can have more than one active temporary duty' do
    temporary = duties(:baum).dup
    temporary.update(unit: units(:cbu))
    assert temporary.valid?
    assert_empty temporary.errors[:base]
  end

  test 'a user can only have one active duty per unit' do
    active = duties(:baum).dup
    assert_not active.valid?
    assert_not_empty active.errors[:base]
    assert active.errors[:base].include?(t('validators.duty.multiple_active'))
  end

  test 'a user can have more than one passive duty' do
    passive = duties(:uzem).dup
    passive.update(unit: units(:baum))
    assert passive.valid?
    assert_empty passive.errors[:base]
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
