# frozen_string_literal: true

require 'test_helper'

class StudentDecoratorTest < ActiveSupport::TestCase
  setup do
    @student = StudentDecorator.new(students(:serhat))
  end
end
