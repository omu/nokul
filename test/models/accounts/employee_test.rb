# frozen_string_literal: true

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # relations
  %i[
    user
    title
    duties
    units
    positions
    administrative_functions
  ].each do |property|
    test "an employee can communicate with #{property}" do
      assert employees(:serhat_active).send(property)
    end
  end

  # validations: uniqueness
  test 'an employee can not have duplicate titles' do
    fake = employees(:serhat_active).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:title_id]
  end

  # delegations
  test 'an employee can reach addresses and identities over user' do
    assert employees(:serhat_active).addresses
    assert employees(:serhat_active).identities
  end

  # scopes
  test 'an employee have defined scopes for active and passive situation' do
    assert users(:serhat).employees.active
    assert users(:serhat).employees.passive
  end

  # employee validator
  test 'a user can only have one active employees' do
    fake = employees(:serhat_active).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:base]
    assert fake.errors[:base].include?(I18n.t('employee.active'))
  end

  # scopes
  test 'active scope returns active employees of user' do
    active = users(:serhat).employees.active
    assert active.to_a.include?(employees(:serhat_active))
    assert_not active.to_a.include?(employees(:serhat_passive))
  end
end
