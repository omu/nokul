# frozen_string_literal: true

class StudentPolicy < ApplicationPolicy
  def edit?
    permitted? :write
  end

  def update?
    permitted? :write
  end

  private

  def permitted?(*privileges)
    user.privilege? :student_management, privileges
  end
end
