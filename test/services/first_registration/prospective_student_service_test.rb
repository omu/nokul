# frozen_string_literal: true

require 'test_helper'

module FirstRegistration
  class ProspectiveStudentServiceTest < ActiveSupport::TestCase
    setup do
      @prospective_student = ProspectiveStudentService.new(prospective_students(:jane))
    end

    test 'register can create a user and a student record' do
      assert_difference ['User.count', 'Student.count'], 1 do
        @prospective_student.register
      end
    end
  end
end
