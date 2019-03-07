# frozen_string_literal: true

module FirstRegistration
  class ProspectiveStudentsController < ApplicationController
    include SearchableModule

    before_action :set_prospective_student, only: %i[show edit update register]
    before_action :can_register?, only: :register

    def index
      prospective_students = ProspectiveStudent.includes(:unit, :student_entrance_type)
                                               .dynamic_search(search_params(ProspectiveStudent))
      @pagy, @prospective_students = pagy(prospective_students)
    end

    def show
      @prospective_student = ProspectiveStudentDecorator.new(@prospective_student)
    end

    def new
      @prospective_student = ProspectiveStudent.new
    end

    def create
      @prospective_student = ProspectiveStudent.new(prospective_student_params)
      @prospective_student.save ? redirect_to(index_path, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      if @prospective_student.update(prospective_student_params)
        redirect_to([:first_registration, @prospective_student], notice: t('.success'))
      else
        render(:edit)
      end
    end

    def register
      prospective_student = FirstRegistration::ProspectiveStudentService.new(@prospective_student)

      if prospective_student.register
        @prospective_student.update(registered: true, archived: true)
        redirect_to(index_path, notice: t('.success'))
      else
        redirect_to(index_path, alert: t('.warning'))
      end
    end

    private

    def index_path
      %i[first_registration prospective_students]
    end

    def set_prospective_student
      @prospective_student = ProspectiveStudent.find(params[:id])
    end

    def can_register?
      redirect_to(index_path, alert: t('.can_not_register')) unless @prospective_student.can_temporarily_register?
    end

    def prospective_student_params
      params.require(:prospective_student)
            .permit(:id_number, :first_name, :last_name, :fathers_name, :mothers_name, :date_of_birth, :gender,
                    :nationality, :place_of_birth, :registration_city, :registration_district, :address, :home_phone,
                    :mobile_phone, :email, :top_student, :high_school_code, :high_school_branch,
                    :high_school_graduation_year, :high_school_type_id, :state_of_education, :placement_type,
                    :exam_score, :placement_score, :placement_rank, :preference_order, :placement_score_type,
                    :additional_score, :meb_status, :meb_status_date, :military_status, :military_status_date,
                    :obs_status, :obs_status_date, :obs_registered_program, :language_id, :unit_id,
                    :student_disability_type_id, :student_entrance_type_id, :academic_term_id, :expiry_date)
    end
  end
end
