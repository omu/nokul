# frozen_string_literal: true

module References
  class StudentEntranceTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_student_entrance_type, only: %i[edit update destroy]

    def index
      @pagy, @student_entrance_types = pagy(StudentEntranceType.all)
    end

    def new
      @student_entrance_type = StudentEntranceType.new
    end

    def edit; end

    def create
      @student_entrance_type = StudentEntranceType.new(student_entrance_type_params)
      @student_entrance_type.save ? redirect_with('success') : render(:new)
    end

    def update
      if @student_entrance_type.update(student_entrance_type_params)
        redirect_to(@student_entrance_type, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @student_entrance_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(student_entrance_types_path, notice: t(".#{message}"))
    end

    def set_student_entrance_type
      @student_entrance_type = StudentEntranceType.find(params[:id])
    end

    def student_entrance_type_params
      params.require(:student_entrance_type).permit(:name, :code)
    end
  end
end
