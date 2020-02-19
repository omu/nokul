# frozen_string_literal: true

module Manager
  module Stats
    class EmployeePolicy < ApplicationPolicy
      def academic?
        user.role?(:admin) || manager?
      end

      def index?
        user.role?(:admin) || manager?
      end

      private

      def manager?
        Patron::Utils::RoleQuerier.new(user).institution_manager?
      end
    end
  end
end
