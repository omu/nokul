# frozen_string_literal: true

module CourseManagement
  class CourseGroupPolicy < ApplicationPolicy
    include CrudPolicyMethods

    private

    def permitted?(*privileges)
      user.privilege? :course_management, privileges
    end
  end
end
