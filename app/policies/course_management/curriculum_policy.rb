# frozen_string_literal: true

module CourseManagement
  class CurriculumPolicy < ApplicationPolicy
    def create?
      permitted? :write
    end

    def destroy?
      permitted? :destroy
    end

    def edit?
      permitted? :write
    end

    def index?
      permitted? :read
    end

    def new?
      permitted? :write
    end

    def openable_courses?
      permitted?(:read) || user.privilege?(:available_course_management, :write)
    end

    def show?
      permitted? :read
    end

    def update?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :curriculum_management, privileges
    end
  end
end
