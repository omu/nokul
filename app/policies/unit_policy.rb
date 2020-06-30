# frozen_string_literal: true

class UnitPolicy < ApplicationPolicy
  include CrudPolicyMethods

  def courses?
    permitted? :read
  end

  def curriculums?
    permitted? :read
  end

  def employees?
    permitted? :read
  end

  def programs?
    permitted? :read
  end

  def students?
    permitted? :read
  end

  private

  def permitted?(*privileges)
    user.privilege? :unit_management, privileges
  end
end
