# frozen_string_literal: true

require 'test_helper'

module FirstRegistration
  class ProspectiveStudentServiceTest < ActiveSupport::TestCase
    setup do
      @prospective_student = ProspectiveStudentService.new(prospective_students(:jane))
    end

    test 'create_user method initializes a user' do
      assert @prospective_student.create_user.is_a?(User)
    end

    test 'create_student method initializes a student' do
      assert @prospective_student.create_student.is_a?(Student)
    end
  end
end
