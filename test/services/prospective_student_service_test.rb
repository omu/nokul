# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentServiceTest < ActiveSupport::TestCase
  test 'creates user and student' do
    @prospective_student = prospective_students(:jane)
    prospective_student = ProspectiveStudentService.new(@prospective_student)
    assert prospective_student.create_user.save
    assert prospective_student.create_student.save
  end
end
