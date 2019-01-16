# frozen_string_literal: true

module FirstRegistration
  class ProspectiveStudentService
    def initialize(prospective_student)
      @prospective_student = prospective_student
    end

    def register
      initialize_user
      initialize_student

      return unless @user.valid? && @student.valid?

      @user.save
      @student.save
    end

    private

    def initialize_user
      @user = User.new(
        id_number: @prospective_student.id_number,
        email: @prospective_student.email,
        password: @prospective_student.id_number,
        password_confirmation: @prospective_student.id_number
      )
    end

    def initialize_student
      @student = Student.new(
        user: @user,
        unit: @prospective_student.unit,
        permanently_registered: @prospective_student.can_permanently_register?,
        student_number: @prospective_student.id_number # TODO: must be generated
      )
    end
  end
end
