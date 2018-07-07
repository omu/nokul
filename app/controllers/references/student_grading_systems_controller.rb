# frozen_string_literal: true

module References
  class StudentGradingSystemsController < ApplicationController
    include Pagy::Backend

    before_action :set_student_grading_system, only: %i[edit update destroy]

    def index
      @pagy, @student_grading_systems = pagy(StudentGradingSystem.all)
    end

    def new
      @student_grading_system = StudentGradingSystem.new
    end

    def edit; end

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
