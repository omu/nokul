# frozen_string_literal: true

class UnitPolicy < ApplicationPolicy
  def courses?
    permitted? :read
  end

  def create?
    permitted? :write
  end

  def curriculums?
    permitted? :read
  end

  def destroy?
    permitted? :destroy
  end

  def edit?
    permitted? :write
  end

  def employees?
    permitted? :read
  end

  def index?
    permitted? :read
  end

  def new?
    permitted? :write
  end

  def programs?
    permitted? :read
  end

  def show?
    permitted? :read
  end

  def update?
    permitted? :write
  end

  private

  def permitted?(*privileges)
    user.privilege? :unit_management, privileges
  end
end
