# frozen_string_literal: true

module Patron
  class AssignmentPolicy < ApplicationPolicy
    def index?
      permitted?
    end

    def show?
      permitted?
    end

    def update?
      permitted?
    end

    def edit?
      update?
    end

    def preview_scope?
      permitted?
    end

    private

    def permitted?
      user.permission? :authorization_management
    end
  end
end
