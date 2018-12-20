# frozen_string_literal: true

require 'test_helper'

class CourseGroupTest < ActiveSupport::TestCase
  setup do
    @course_group = course_groups(:bilgisayar_muhendligi_teknik_secmeli_1)
  end

  # relations
  %i[
    unit
    course_group_type
    group_courses
    courses
    curriculum_course_groups
  ].each do |property|
    test "a course group can communicate with #{property}" do
      assert @course_group.send(property)
    end
  end

  # validations: presence
  %i[
    name
    total_ects_condition
    course_ids
  ].each do |property|
    test "presence validations for #{property} of a course group" do
      @course_group.send("#{property}=", nil)
      assert_not @course_group.valid?
      assert_not_empty @course_group.errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for name of a course group' do
    fake = @course_group.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
    fake.unit_id = units(:matematik_ve_fen_bilimleri_egitimi_bolumu).id
    fake.valid?
    assert_empty fake.errors[:name]
  end
end
