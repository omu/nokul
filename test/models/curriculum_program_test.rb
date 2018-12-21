# frozen_string_literal: true

require 'test_helper'

class CurriculumProgramTest < ActiveSupport::TestCase
  # relations
  %i[
    curriculum
    unit
  ].each do |property|
    test "a curriculum program can communicate with #{property}" do
      assert curriculum_programs(:one).send(property)
    end
  end
end
