# frozen_string_literal: true

module Committee
  class MeetingPolicy < ApplicationPolicy
    include CrudPolicyMethods

    private

    def permitted?(*privileges)
      user.privilege? :meeting_management, privileges
    end
  end
end
