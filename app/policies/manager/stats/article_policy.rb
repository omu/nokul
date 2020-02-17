# frozen_string_literal: true

module Manager
  module Stats
    class ArticlePolicy < ApplicationPolicy
      def index?
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
