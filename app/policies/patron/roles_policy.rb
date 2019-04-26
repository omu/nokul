# frozen_string_literal: true

module Patron
  class RolesPolicy < ApplicationPolicy
    def index?
      false
    end

    def show?
      false
    end

    def create?
      false
    end

    def new?
      create?
    end

    def update?
      false
    end

    def edit?
      update?
    end

    def destroy?
      false
    end
  end
end
