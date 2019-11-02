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

  test 'elective_ids method' do
    elective_ids = @curriculum_semester.elective_ids.flatten.sort
    assert_equal elective_ids, [available_courses(:elective_course).id, available_courses(:elective_course_2).id].sort
  end

  test 'compulsory_ids method' do
    compulsory_ids = @curriculum_semester.compulsory_ids
    assert_equal compulsory_ids, [available_courses(:compulsory_course).id, available_courses(:compulsory_course_2).id]
  end
end
