# frozen_string_literal: true

module Reference
  class StudentGradingSystemsController < ApplicationController
    include Pagy::Backend

    before_action :set_student_grading_system, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @student_grading_systems = pagy(StudentGradingSystem.all)
    end

    def show
      breadcrumb @student_grading_system.name, student_grading_system_path
    end

    def new
      breadcrumb t('.form_title'), new_student_grading_system_path
      @student_grading_system = StudentGradingSystem.new
    end

    def edit
      breadcrumb t('.form_title'), edit_student_grading_system_path
    end

    def create
      @student_grading_system = StudentGradingSystem.new(student_grading_system_params)
      @student_grading_system.save ? redirect_with('success') : render(:new)
    end

    def update
      if @student_grading_system.update(student_grading_system_params)
        redirect_to(@student_grading_system, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @student_grading_system.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), student_grading_systems_path, match: :exact
    end

    def redirect_with(message)
      redirect_to(student_grading_systems_path, notice: t(".#{message}"))
    end

    def set_student_grading_system
      @student_grading_system = StudentGradingSystem.find(params[:id])
    end

    def student_grading_system_params
      params.require(:student_grading_system).permit(:name, :code)
    end
  end
end
