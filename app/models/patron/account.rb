# frozen_string_literal: true

module Patron
  class Account
    attr_reader :user, :accounts

    class Error < StandardError; end
    class NotFound < Error; end

    def initialize(user)
      @user     = Utils::RoleQuerier.new(user)
      @accounts = []
      build_accounts
    end

    class << self
      def call(user)
        new(user).accounts
      end

      def find_by(user:, type:, id:)
        klass   = "Patron::Accounts::#{type.to_s.camelize}".safe_constantize
        account = klass&.new(id, user.id)
        account&.verify? ? account : raise(NotFound)
      end
    end

    private

    def build_accounts
      build_for_institution_manager
      build_for_admin
      build_for_employee
      build_for_student
    end

    def build_for_student
      user.students.active.each { |student| accounts << Accounts::Student.new(student.id, user.id) }
    end

    def build_for_employee
      user.employees.active.each { |employee| accounts << Accounts::Employee.new(employee.id, user.id) }
    end

    def build_for_admin
      accounts << Accounts::Admin.new(user.id, user.id) if user.admin?
    end

    def build_for_institution_manager
      accounts << Accounts::InstitutionManager.new(user.id, user.id) if user.institution_manager?
    end
  end
end
