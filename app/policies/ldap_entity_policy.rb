# frozen_string_literal: true

class LdapEntityPolicy < ApplicationPolicy
  def index?
    permitted? :read
  end

  def show?
    permitted? :read
  end

  def start_sync?
    permitted? :write
  end

  private

  def permitted?(*privileges)
    user.privilege? :ldap_management, privileges
  end
end
