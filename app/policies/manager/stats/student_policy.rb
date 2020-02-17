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

      private

      def manager?
        user.positions.active.exists?(
          administrative_function_id: AdministrativeFunction.where(name: ['Rektör', 'Rektör Yardımcısı']).ids
        )
      end
    end
  end
end
