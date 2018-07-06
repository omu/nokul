# frozen_string_literal: true

module Reference
  class StudentDisabilityTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_student_disability_type, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @student_disability_types = pagy(StudentDisabilityType.all)
    end

    def show
      breadcrumb @student_disability_type.name, student_disability_type_path
    end

    def new
      breadcrumb t('.form_title'), new_student_disability_type_path
      @student_disability_type = StudentDisabilityType.new
    end

    def edit
      breadcrumb t('.form_title'), edit_student_disability_type_path
    end

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

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), student_disability_types_path, match: :exact
    end

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
