# frozen_string_literal: true

require 'test_helper'

class CourseGroupTypeTest < ActiveSupport::TestCase
  # relations
  %i[
    course_groups
  ].each do |property|
    test "a course group type can communicate with #{property}" do
      assert course_group_types(:one).send(property)
    end
  end

  # validations: presence
  test 'should not save course group type without name' do
    course_group_types(:one).name = nil
    assert_not course_group_types(:one).valid?
    assert_not_empty course_group_types(:one).errors[:name]
  end
end
