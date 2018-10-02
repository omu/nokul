# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentServiceTest < ActiveSupport::TestCase
  test 'creates user and student' do
    skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
    @prospective_student = prospective_students(:jane)
    prospective_student = ProspectiveStudentService.new(@prospective_student)
    assert prospective_student.create_user.save
    assert prospective_student.create_student.save
  end
end
