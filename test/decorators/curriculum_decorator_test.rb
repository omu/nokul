# frozen_string_literal: true

require 'test_helper'

class CurriculumDecoratorTest < ActiveSupport::TestCase
  setup do
    @curriculum = CurriculumDecorator.new(curriculums(:one))
  end

  test 'openable_courses_for_active_term method' do
    courses = @curriculum.openable_courses_for_active_term

    assert_not_includes courses, courses(:ati)
    assert_not_includes courses, courses(:test)
    assert_includes courses, courses(:ydi)
  end
end
