# frozen_string_literal: true

require 'test_helper'

class StudentDecoratorTest < ActiveSupport::TestCase
  setup do
    @student = StudentDecorator.new(
      students(:serhat)
    )
  end

  test 'registrable_for_online_course? method' do
    assert_not @student.registrable_for_online_course?
  end
end
