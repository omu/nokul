# frozen_string_literal: true

module Patron
  class AssignmentPolicy < ApplicationPolicy
    def index?
      permitted?
    end

    private

    def permitted?
      user.permission? :authorization_management
    end
  end
end
