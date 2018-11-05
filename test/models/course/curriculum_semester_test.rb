# frozen_string_literal: true

require 'test_helper'

class CurriculumSemesterTest < ActiveSupport::TestCase
  setup do
    @semester = curriculum_semesters(:one)
  end

  # relations
  test 'curriculum semester can communicate with curriculum' do
    assert @semester.curriculum
  end

  # validations: presence
  %i[
    name
    sequence
  ].each do |property|
    test "presence validations for #{property} of a curriculum semester" do
      @semester.send("#{property}=", nil)
      assert_not @semester.valid?
      assert_not_empty @semester.errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for name of a curriculum semester' do
    fake = @semester.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]

    fake.curriculum_id = curriculums(:three).id
    fake.sequence = 12
    assert fake.valid?
    assert_empty fake.errors[:name]
  end

  # validations: numericality
  test 'numericality validations for sequence of a curriculum semester' do
    @semester.sequence = 0
    assert_not @semester.valid?
    assert_not_empty @semester.errors[:sequence]
  end
end
