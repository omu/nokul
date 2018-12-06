# frozen_string_literal: true

module StudentManagement
  class ProspectiveStudentsController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_prospective_student, only: %i[show register]
    before_action :can_register?, only: :register

    def index
      prospective_students = ProspectiveStudent.includes(:unit, :student_entrance_type)
                                               .dynamic_search(search_params(ProspectiveStudent))
      @pagy, @prospective_students = pagy(prospective_students)
    end

    def show
      @prospective_student = ProspectiveStudentDecorator.new(@prospective_student)
    end

    def register
      prospective_student = ProspectiveStudentService.new(@prospective_student)
      user = prospective_student.create_user

      if user.save
        student = prospective_student.create_student
        student.save ? redirect_with_success : redirect_with_warning('.warning')
      else
        redirect_with_warning('.warning')
      end

      @prospective_student.update(registered: true)
    end

    private

    def set_prospective_student
      @prospective_student = ProspectiveStudent.find(params[:id])
    end

    def can_register?
      redirect_with_warning('.can_not_register') unless @prospective_student.can_temporarily_register?
    end

    def redirect_with_success
      redirect_to(prospective_students_path, flash: { notice: t('.success') })
    end

    def redirect_with_warning(message)
      redirect_to(prospective_students_path, flash: { alert: t(".#{message}") })
    end
  end
end
