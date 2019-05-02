# frozen_string_literal: true

module FirstRegistration
  module ProspectiveEmployeeService
    def employee
      @employee ||= Employee.new(
        user: user,
        title_id: prospective.title_id,
        staff_number: prospective.staff_number
      )
    end

    def valid?
      [prospective, employee, user].all?(&:valid?)
    end

    def register
      return set_error_messages unless valid?

      user.save
      employee.save
    end

    def error_messages
      employee.errors.messages.merge(user.errors.messages)
    end
  end
end
