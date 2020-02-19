# frozen_string_literal: true

module CourseManagement
  class CurriculumCourseGroupPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :index?, :show?

    private

    def permitted?(*privileges)
      user.privilege? :curriculum_management, privileges
    end
  end
end
