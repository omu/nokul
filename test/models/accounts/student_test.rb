# frozen_string_literal: true

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  # relations
  %i[
    user
    unit
    identity
  ].each do |property|
    test "a student can communicate with #{property}" do
      assert students(:serhat).send(property)
    end
  end

  # validations: presence
  test 'presence validations for student_number of a student' do
    students(:serhat).update(student_number: nil)
    assert_not students(:serhat).valid?
    assert_not_empty students(:serhat).errors[:student_number]
  end

  # validations: uniqueness
  test 'a student can not have a duplicate unit and a duplicate student number' do
    fake = students(:serhat).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:student_number]
    assert_not_empty fake.errors[:unit_id]
  end

  # delegations
  test 'a student can communicate with addresses over the user' do
    assert students(:serhat).addresses
  end

  # callback tests
  test 'student runs KpsIdentityCreateOrUpdateJob after being created' do
    assert_enqueued_with(job: KpsIdentityCreateOrUpdateJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu))
    end
  end
end
