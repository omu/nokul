# frozen_string_literal: true

module Patron
  module Accounts
    class Employee < Base
      def object
        @object ||= user.employees.find(id)
      end

      def label
        "#{I18n.t('patron.accounts.employee')} - #{object&.title_name} (#{object.staff_number})"
      end

      def type
        'employee'
      end

      def verify?
        object.present?
      end
    end
  end
end
