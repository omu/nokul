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
      @prospective_student.save ? redirect_to(:prospective_students, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      if @prospective_student.update(prospective_student_params)
        redirect_to(@prospective_student, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def register
      prospective_student = FirstRegistration::ProspectiveStudentService.new(@prospective_student)

      if prospective_student.register
        @prospective_student.update(registered: true)
        if User.exists?(id_number: @prospective_student.id_number, activated: true)
          @prospective_student.update(archived: true)
        end
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
      alert = '.can_not_register'
      redirect_to(:prospective_students, alert: t(alert)) unless @prospective_student.can_temporarily_register?
    end

    # rubocop:disable Metrics/MethodLength
    def prospective_student_params
      params.require(:prospective_student).permit(
        :academic_term_id,
        :additional_score,
        :address,
        :date_of_birth,
        :email,
        :exam_score,
        :expiry_date,
        :fathers_name,
        :first_name,
        :gender,
        :high_school_branch,
        :high_school_code,
        :high_school_graduation_year,
        :high_school_type_id,
        :home_phone,
        :id_number,
        :language_id,
        :last_name,
        :meb_status,
        :meb_status_date,
        :military_status,
        :military_status_date,
        :mobile_phone,
        :mothers_name,
        :nationality,
        :obs_registered_program,
        :obs_status,
        :obs_status_date,
        :place_of_birth,
        :placement_rank,
        :placement_score,
        :placement_score_type,
        :placement_type,
        :preference_order,
        :registration_city,
        :registration_district,
        :state_of_education,
        :student_disability_type_id,
        :student_entrance_type_id,
        :top_student,
        :unit_id
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
