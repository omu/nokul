# frozen_string_literal: true

module FirstRegistration
  class ProspectiveStudentsController < ApplicationController
    include SearchableModule

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
      prospective_student = FirstRegistration::ProspectiveStudentService.new(@prospective_student)

      if prospective_student.register
        @prospective_student.update(registered: true)
        redirect_to(:prospective_students, notice: t('.success'))
      else
        redirect_to(:prospective_students, alert: t('.warning'))
      end
    end

    private

    def set_prospective_student
      @prospective_student = ProspectiveStudent.find(params[:id])
    end

    def can_register?
      redirect_with_warning('.can_not_register') unless @prospective_student.can_temporarily_register?
    end
  end
end
