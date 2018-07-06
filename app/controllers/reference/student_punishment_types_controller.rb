# frozen_string_literal: true

module Reference
  class StudentPunishmentTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_student_punishment_type, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @student_punishment_types = pagy(StudentPunishmentType.all)
    end

    def show
      breadcrumb @student_punishment_type.name, student_punishment_type_path
    end

    def new
      breadcrumb t('.form_title'), new_student_punishment_type_path
      @student_punishment_type = StudentPunishmentType.new
    end

    def edit
      breadcrumb t('.form_title'), edit_student_punishment_type_path
    end

    def create
      @student_punishment_type = StudentPunishmentType.new(student_punishment_type_params)
      @student_punishment_type.save ? redirect_with('success') : render(:new)
    end

    def update
      if @student_punishment_type.update(student_punishment_type_params)
        redirect_to(@student_punishment_type, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @student_punishment_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), student_punishment_types_path, match: :exact
    end

    def redirect_with(message)
      redirect_to(student_punishment_types_path, notice: t(".#{message}"))
    end

    def set_student_punishment_type
      @student_punishment_type = StudentPunishmentType.find(params[:id])
    end

    def student_punishment_type_params
      params.require(:student_punishment_type).permit(:name, :code)
    end
  end
end
