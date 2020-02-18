# frozen_string_literal: true

module Patron
  module Accounts
    class Employee < Base
      def object
        @object ||= user.employees.find(id)
      end

      def label
        "#{object.staff_number} - #{object&.title_name}"
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
