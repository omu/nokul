# frozen_string_literal: true

module FirstRegistration
  module ProspectiveStudentService
    def student
      @student ||= Student.new(
        user: user,
        unit: prospective.unit,
        permanently_registered: prospective.can_permanently_register?,
        student_number: prospective.id_number # TODO: must be generated
      )
    end

    def valid?
      [prospective, student, user].all?(&:valid?)
    end

    def register
      return set_error_messages unless valid?

      user.save
      student.save
    end

    def error_messages
      student.errors.messages.merge(user.errors.messages)
    end
  end
end
