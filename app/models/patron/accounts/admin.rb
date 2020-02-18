# frozen_string_literal: true

module Patron
  module Accounts
    class Admin < Base
      def object
        user
      end

      def label
        I18n.t('patron.accounts.admin')
      end

      def type
        'admin'
      end

      def verify?
        object.present?
      end
    end
  end
end
