# frozen_string_literal: true

module CourseManagement
  class AvailableCourseGroupPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :index?, :show?

    private

    def permitted?(*privileges)
      user.privilege? :available_course_management, privileges
    end
  end
end
