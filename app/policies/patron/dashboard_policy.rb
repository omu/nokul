# frozen_string_literal: true

module Patron
  class DashboardPolicy < ApplicationPolicy
    def index?
      user.role? :authorization_manager
    end
  end
end
