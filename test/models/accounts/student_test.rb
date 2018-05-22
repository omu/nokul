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
  %i[
    student_number
    user
    unit
  ].each do |property|
    test "presence validations for #{property} of a student" do
      students(:serhat).send("#{property}=", nil)
      assert_not students(:serhat).valid?
      assert_not_empty students(:serhat).errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for student_number of a student' do
    fake = students(:serhat).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:student_number]
  end

  # callback tests
  test 'student runs KpsIdentityCreateJob after being created' do
    assert_enqueued_with(job: KpsIdentityCreateJob) do
      Student.create(student_number: '1234', user: users(:serhat), unit: units(:omu))
    end
  end
end
