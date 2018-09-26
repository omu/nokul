# frozen_string_literal: true

module StudentManagement
  class ProspectiveStudentsController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_prospective_student, only: %i[show register]

    def index
      prospective_students = ProspectiveStudent.includes(:unit, :student_entrance_type)
                                               .dynamic_search(search_params(ProspectiveStudent))
      @pagy, @prospective_students = pagy(prospective_students)
    end

    def show; end

    def register
      
    end

    private

    def redirect_with(message)
      redirect_to prospective_students_path, flash: { info: t(".#{message}") }
    end

    def set_prospective_student
      @prospective_student = ProspectiveStudent.find(params[:id])
    end
  end
end
