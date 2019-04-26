# frozen_string_literal: true

module FirstRegistration
  class ProspectiveService
    def initialize(prospective)
      @prospective = prospective
    end

    def register
      initialize_user
      case @prospective.class.name
      when 'ProspectiveEmployee'
        employee_process
      when 'ProspectiveStudent'
        student_process
      end
    end

    private

    def user_exists?
      User.exists?(id_number: @prospective.id_number)
    end

    def initialize_user
      @user =
        if user_exists?
          User.find_by(id_number: @prospective.id_number)
        else
          User.new(id_number: @prospective.id_number,
                   email: @prospective.email,
                   password: @prospective.id_number,
                   password_confirmation: @prospective.id_number)
        end
    end

    def initialize_student
      @student = Student.new(
        user: @user,
        unit: @prospective.unit,
        permanently_registered: @prospective.can_permanently_register?,
        student_number: @prospective.id_number # TODO: must be generated
      )
    end

    def initialize_employee
      @employee = Employee.new(
        user: @user,
        title_id: @prospective.title_id,
        staff_number: @prospective.staff_number
      )
    end

    def employee_valid?
      @employee.valid? && @user.valid? && @prospective.valid?
    end

    def student_valid?
      @student.valid? && @user.valid? && @prospective.valid?
    end

    def employee_process
      initialize_employee
      return error_messages(@user, @employee) && false unless employee_valid?

      @user.save
      @employee.save
    end

    def student_process
      initialize_student
      return error_messages(@user, @student) && false unless student_valid?

      @user.save
      @student.save
    end

    def error_messages(user, prospective)
      prospective.errors.messages.merge(user.errors.messages).each do |key, message|
        @prospective.errors.add(key, message.join(''))
        @prospective.errors.full_messages
      end
    end
  end
end
