# frozen_string_literal: true

module Reference
  class StudentDropOutTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_student_drop_out_type, only: %i[show edit update destroy]

    def index
      @pagy, @student_drop_out_types = pagy(StudentDropOutType.all)
    end

    def show
    end

    def new
      @student_drop_out_type = StudentDropOutType.new
    end

    def edit
    end

    def create
      @student_drop_out_type = StudentDropOutType.new(student_drop_out_type_params)
      @student_drop_out_type.save ? redirect_with('success') : render(:new)
    end

    def update
      if @student_drop_out_type.update(student_drop_out_type_params)
        redirect_to(@student_drop_out_type, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @student_drop_out_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(student_drop_out_types_path, notice: t(".#{message}"))
    end

    def set_student_drop_out_type
      @student_drop_out_type = StudentDropOutType.find(params[:id])
    end

    def student_drop_out_type_params
      params.require(:student_drop_out_type).permit(:name, :code)
    end
  end
end
