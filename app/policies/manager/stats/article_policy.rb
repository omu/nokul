# frozen_string_literal: true

module Manager
  module Stats
    class ArticlePolicy < ApplicationPolicy
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
