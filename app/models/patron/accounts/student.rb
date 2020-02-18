# frozen_string_literal: true

module Patron
  module Accounts
    class Student < Base
      def object
        @object ||= user.students.find(id)
      end

      def label
        "#{object.student_number} - #{object&.identity&.first_name} #{object&.identity&.last_name}"
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
