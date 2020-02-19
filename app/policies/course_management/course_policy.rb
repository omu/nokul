# frozen_string_literal: true

module CourseManagement
  class CoursePolicy < ApplicationPolicy
    include CrudPolicyMethods

    private

    def permitted?(*privileges)
      user.privilege? :course_management, privileges
    end
  end
end
