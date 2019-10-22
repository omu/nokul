# frozen_string_literal: true

require 'test_helper'

class StudentDecoratorTest < ActiveSupport::TestCase
  test 'registrable_for_online_course? method' do
    assert_not StudentDecorator.new(students(:serhat)).registrable_for_online_course?
    assert StudentDecorator.new(students(:serhat_omu)).registrable_for_online_course?
  end
end
