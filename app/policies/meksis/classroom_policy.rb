# frozen_string_literal: true

module Meksis
  class ClassroomPolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    def show?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :meksis_management, privileges
    end
  end
end
