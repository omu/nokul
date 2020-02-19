# frozen_string_literal: true

module CourseManagement
  class CourseTypePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :course_management, privileges
    end
  end
end
