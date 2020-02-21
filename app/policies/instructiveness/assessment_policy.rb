# frozen_string_literal: true

module Instructiveness
  class AssessmentPolicy < ApplicationPolicy
    def edit?
      permitted?
    end

    def update?
      permitted?
    end

    private

    def permitted?
      user&.employee? && user.current_employee&.academic?
    end
  end
end
