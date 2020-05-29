# frozen_string_literal: true

module CourseManagement
  class AvailableCoursePolicy < ApplicationPolicy
    include CrudPolicyMethods

    def destroy?
      permitted?(:destroy) && record.manageable?
    end

    private

    def permitted?(*privileges)
      user.privilege? :available_course_management, privileges
    end
  end
end
