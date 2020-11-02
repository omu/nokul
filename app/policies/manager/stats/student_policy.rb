# frozen_string_literal: true

module Manager
  module Stats
    class StudentPolicy < ApplicationPolicy
      def cities?
        user.role?(:admin) || manager?
      end

      def double_major_and_minor?
        user.role?(:admin) || manager?
      end

      def genders?
        user.role?(:admin) || manager?
      end

      def genders_and_degrees?
        user.role?(:admin) || manager?
      end

      def index?
        user.role?(:admin) || manager?
      end

      def non_graduates?
        user.role?(:admin) || manager?
      end

      def units?
        user.role?(:admin) || manager?
      end

      private

      def manager?
        Patron::Utils::RoleQuerier.new(user).institution_manager?
      end
    end
  end
end
