# frozen_string_literal: true

module CourseManagement
  class AvailableCoursePolicy < ApplicationPolicy
    include CrudPolicyMethods

    private

    def permitted?(*privileges)
      user.privilege? :available_course_management, privileges
    end
  end
end
