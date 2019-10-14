# frozen_string_literal: true

require 'test_helper'

class CurriculumDecoratorTest < ActiveSupport::TestCase
  setup do
    @curriculum = CurriculumDecorator.new(curriculums(:one))
  end

  test 'openable_courses_for_active_term method' do
    curriculum_course_ids = @curriculum.openable_courses_for_active_term.pluck(:id)

    assert_not_includes curriculum_course_ids, curriculum_courses(:one).id
    assert_not_includes curriculum_course_ids, curriculum_courses(:elective_course).id
    assert_includes curriculum_course_ids, curriculum_courses(:ydi).id
  end
end
