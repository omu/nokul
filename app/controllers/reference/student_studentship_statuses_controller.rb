# frozen_string_literal: true

module Reference
  class StudentStudentshipStatusesController < ApplicationController
    include Pagy::Backend

    before_action :set_student_studentship_status, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @student_studentship_statuses = pagy(StudentStudentshipStatus.all)
    end

    def show
      breadcrumb @student_studentship_status.name, student_studentship_status_path
    end

    def new
      breadcrumb t('.form_title'), new_student_studentship_status_path
      @student_studentship_status = StudentStudentshipStatus.new
    end

    def edit
      breadcrumb t('.form_title'), edit_student_studentship_status_path
    end

    def create
      @student_studentship_status = StudentStudentshipStatus.new(student_studentship_status_params)
      @student_studentship_status.save ? redirect_with('success') : render(:new)
    end

    def update
      if @student_studentship_status.update(student_studentship_status_params)
        redirect_to(@student_studentship_status, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @student_studentship_status.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), student_studentship_statuses_path, match: :exact
    end

    def redirect_with(message)
      redirect_to(student_studentship_statuses_path, notice: t(".#{message}"))
    end

    def set_student_studentship_status
      @student_studentship_status = StudentStudentshipStatus.find(params[:id])
    end

    def student_studentship_status_params
      params.require(:student_studentship_status).permit(:name, :code)
    end
  end
end
