# frozen_string_literal: true

module Instructiveness
  class GivenCoursePolicy < ApplicationPolicy
    def index?
      permitted?
    end

    def show?
      permitted?
    end

    def students?
      permitted?
    end

    private

    def permitted?
      user&.employee? && user.current_employee&.academic?
    end
  end
end
