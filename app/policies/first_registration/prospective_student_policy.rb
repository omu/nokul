# frozen_string_literal: true

module FirstRegistration
  class ProspectiveStudentPolicy < ApplicationPolicy
    def create?
      new?
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

    def register?
      permitted? :write
    end

    def show?
      permitted? :read
    end

    def update?
      edit?
    end

    private

    def permitted?(*privileges)
      user.privilege? :registration_management_for_students, privileges
    end
  end
end
