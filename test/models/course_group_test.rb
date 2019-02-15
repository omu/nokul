# frozen_string_literal: true

require 'test_helper'

class CourseGroupTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @course_group = course_groups(:bilgisayar_muhendligi_teknik_secmeli_1)
  end

  # relations
  belongs_to :course_group_type
  belongs_to :unit
  has_many :courses
  has_many :curriculum_course_groups
  has_many :group_courses

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
