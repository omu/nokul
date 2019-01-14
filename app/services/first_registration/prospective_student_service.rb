# frozen_string_literal: true

module FirstRegistration
  class ProspectiveStudentService
    def initialize(prospective_student)
      @prospective_student = prospective_student
    end

    def create_user
      User.new(
        id_number: @prospective_student.id_number,
        email: @prospective_student.email,
        password: @prospective_student.id_number,
        password_confirmation: @prospective_student.id_number
      )
    end

    def create_student
      Student.new(
        user: User.find_by(id_number: @prospective_student.id_number),
        unit: @prospective_student.unit,
        permanently_registered: @prospective_student.can_permanently_register? ? true : false,
        student_number: @prospective_student.id_number # TODO: must be generated
      )
    end
  end
end
