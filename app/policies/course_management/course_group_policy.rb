# frozen_string_literal: true

module CourseManagement
  class CourseGroupPolicy < ApplicationPolicy
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

    def show?
      permitted? :read
    end

    def update?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :course_management, privileges
    end
  end
end
