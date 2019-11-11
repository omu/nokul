# frozen_string_literal: true

require 'test_helper'

class CurriculumSemesterDecoratorTest < ActiveSupport::TestCase
  setup do
    @curriculum_semester = CurriculumSemesterDecorator.new(
      curriculum_semesters(:bilgisayar_muh_mufredati_ucuncu_donem)
    )
  end

  test 'selectable_courses method' do
    courses = @curriculum_semester.selectable_courses
    assert_not_includes courses, courses(:test)
    assert_not_includes courses, [courses(:java), courses(:mobil_programlama)]
    assert_includes courses, courses(:programlamaya_giris)

    courses = @curriculum_semester.selectable_courses(appends: [courses(:test)])
    assert_includes courses, courses(:test)
  end

  test 'selectable_course_groups method' do
    course_groups = @curriculum_semester.selectable_course_groups
    assert_not_includes course_groups, course_groups(:bilgisayar_muhendligi_teknik_secmeli_1)
    assert_includes course_groups, course_groups(:bilgisayar_muhendligi_teknik_secmeli_2)

    course_groups = @curriculum_semester.selectable_course_groups(
      appends: [course_groups(:bilgisayar_muhendligi_teknik_secmeli_1)]
    )
    assert_includes course_groups, course_groups(:bilgisayar_muhendligi_teknik_secmeli_1)
  end

  test 'active_available_courses method' do
    courses = @curriculum_semester.active_available_courses
    assert_equal courses[0].to_a, [available_courses(:elective_course_2), available_courses(:elective_course)]
    assert_equal courses[1].to_a, [available_courses(:compulsory_course)]
    assert_equal courses[2].to_a, [available_courses(:compulsory_course_2)]
  end
end
