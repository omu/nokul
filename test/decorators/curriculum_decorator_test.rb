# frozen_string_literal: true

require 'test_helper'

class CurriculumDecoratorTest < ActiveSupport::TestCase
  setup do
    @curriculum = CurriculumDecorator.new(curriculums(:one))
  end

  test 'openable_courses_for_active_term method' do
    courses = @curriculum.openable_courses_for_active_term

    assert_not_includes courses, curriculum_courses(:one)
    assert_not_includes courses, curriculum_courses(:elective_course)
    assert_includes courses, curriculum_courses(:ydi)
  end
end
