# frozen_string_literal: true

require 'test_helper'

module FirstRegistration
  class ProspectiveServiceTest < ActiveSupport::TestCase
    setup do
      @prospective_student = ProspectiveService.new(prospective_students(:jane))
      @prospective_employee = ProspectiveService.new(prospective_employees(:hira))
    end

    test 'register can create a user and a student record' do
      assert_difference ['User.count', 'Student.count'], 1 do
        @prospective_student.register
      end
    end

    test 'register can create a user and a employee record' do
      assert_difference ['User.count', 'Employee.count'], 1 do
        @prospective_employee.register
      end
    end
  end
end
