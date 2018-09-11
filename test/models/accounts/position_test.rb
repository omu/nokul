# frozen_string_literal: true

require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  # relations
  %i[
    duty
    administrative_function
  ].each do |property|
    test "an identity can communicate with #{property}" do
      assert positions(:baum_dean).send(property)
    end
  end

  # validations: presence
  %i[
    start_date
  ].each do |property|
    test "presence validations for #{property} of a position" do
      positions(:baum_dean).send("#{property}=", nil)
      assert_not positions(:baum_dean).valid?
      assert_not_empty positions(:baum_dean).errors[property]
    end
  end

  # validations: uniqueness
  test 'a user can not have duplicate positions in a department' do
    fake = positions(:baum_dean).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:duty]
  end

  # position validator
  test 'start date must be before end date' do
    fake = positions(:baum_dean).dup
    fake.update(end_date: fake.start_date - 1.year)
    assert_not fake.valid?
    assert_not_empty fake.errors[:end_date]
    assert fake.errors[:end_date].include?(t('validators.position.invalid_end_date'))
  end

  test 'a user can not have same active position in same unit' do
    active = positions(:uzem_yok_member).dup
    active.update(start_date: active.start_date + 1.year)
    assert_not active.valid?
    assert_not_empty active.errors[:base]
    assert active.errors[:base].include?(t('validators.position.multiple_active_repetitive'))
  end

  test 'a user can have different active positions in same unit' do
    active = positions(:uzem_yok_member).dup
    active.update(administrative_function: administrative_functions(:rector))
    assert active.valid?
    assert_empty active.errors[:base]
  end

  test 'a user can have same active positions in different units' do
    active = positions(:uzem_yok_member).dup
    active.update(duty: duties(:omu))
    assert active.valid?
    assert_empty active.errors[:base]
  end

  test 'a user can have passive same positions in same unit' do
    passive = positions(:baum_dean).dup
    passive.update(start_date: passive.start_date - 1.year)
    assert passive.valid?
    assert_empty passive.errors[:base]
  end
end
