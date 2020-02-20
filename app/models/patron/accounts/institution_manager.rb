# frozen_string_literal: true

module Patron
  module Accounts
    class InstitutionManager < Base
      def object
        user
      end

      def label
        I18n.t('patron.accounts.institution_manager')
      end

      def type
        'institution_manager'
      end

      def verify?
        object.present?
      end

      def root_path
        %i[manager stats]
      end
    end
  end
end
