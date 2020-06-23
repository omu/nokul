# frozen_string_literal: true

class RegulationPolicy < ApplicationPolicy
  def index?
    permitted? :read
  end

  def show?
    permitted? :read
  end

  alias clause? show?

  private

  def permitted?(*privileges)
    user.privilege? :regulation_management, privileges
  end
end
