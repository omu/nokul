# frozen_string_literal: true

module Studentship
  class TuitionDebtPolicy < ApplicationPolicy
    def index?
      permitted?
    end

    private

    def permitted?
      user&.student?
    end
  end
end
