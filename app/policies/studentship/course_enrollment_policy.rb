# frozen_string_literal: true

module Studentship
  class CourseEnrollmentPolicy < ApplicationPolicy
    def create?
      permitted?
    end

    def destroy?
      permitted?
    end

    def index?
      permitted?
    end

    def list?
      permitted?
    end

    def new?
      permitted?
    end

    def save?
      permitted?
    end

    private

    def permitted?
      user&.student?
    end
  end
end
