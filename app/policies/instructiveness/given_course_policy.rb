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
      user&.employee? && record&.academic?
    end
  end
end
