# frozen_string_literal: true

module References
  class StudentDisabilityTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_student_disability_type, only: %i[edit update destroy]

    def index
      @pagy, @student_disability_types = pagy(StudentDisabilityType.all)
    end

    def new
      @student_disability_type = StudentDisabilityType.new
    end

    def edit; end

    def create
      @student_disability_type = StudentDisabilityType.new(student_disability_type_params)
      @student_disability_type.save ? redirect_with('success') : render(:new)
    end

    def update
      if @student_disability_type.update(student_disability_type_params)
        redirect_to(@student_disability_type, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @student_disability_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(student_disability_types_path, notice: t(".#{message}"))
    end

    def set_student_disability_type
      @student_disability_type = StudentDisabilityType.find(params[:id])
    end

    def student_disability_type_params
      params.require(:student_disability_type).permit(:name, :code)
    end
  end
end
