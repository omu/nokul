# frozen_string_literal: true

module CourseManagement
  class AvailableCourseGroupPolicy < ApplicationPolicy
    def create?
      permitted? :write
    end

    def destroy?
      permitted? :destroy
    end

    def edit?
      permitted? :write
    end

    def new?
      permitted? :write
    end

    def update?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :available_course_management, privileges
    end
  end
end
