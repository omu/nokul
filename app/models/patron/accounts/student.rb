# frozen_string_literal: true

module Patron
  module Accounts
    class Student < Base
      def object
        @object ||= user.students.find(id)
      end

      def label
        "#{I18n.t('patron.accounts.student')} - #{object.student_number}"
      end

      def type
        'student'
      end

      def verify?
        object.present?
      end
    end
  end
end
