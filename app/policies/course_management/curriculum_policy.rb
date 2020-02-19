# frozen_string_literal: true

module CourseManagement
  class CurriculumPolicy < ApplicationPolicy
    include CrudPolicyMethods

    def openable_courses?
      permitted?(:read) || user.privilege?(:available_course_management, :write)
    end

    private

    def permitted?(*privileges)
      user.privilege? :curriculum_management, privileges
    end
  end
end
