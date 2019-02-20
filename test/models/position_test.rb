# frozen_string_literal: true

require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :administrative_function
  belongs_to :duty

  # validations: presence
  validates_presence_of :start_date

  # validations: uniqueness
  validates_uniqueness_of :duty

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
