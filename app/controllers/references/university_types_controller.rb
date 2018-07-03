# frozen_string_literal: true

module References
  class UniversityTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_university_type, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @university_types = pagy(UniversityType.all)
    end

    def show
      breadcrumb @university_type.name, university_type_path
    end

    def new
      breadcrumb t('.form_title'), new_university_type_path
      @university_type = UniversityType.new
    end

    def edit
      breadcrumb t('.form_title'), edit_university_type_path
    end

    def create
      @university_type = UniversityType.new(university_type_params)
      @university_type.save ? redirect_with('success') : render(:new)
    end

    def update
      if @university_type.update(university_type_params)
        redirect_to(@university_type, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @university_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), university_types_path, match: :exact
    end

    def redirect_with(message)
      redirect_to(university_types_path, notice: t(".#{message}"))
    end

    def set_university_type
      @university_type = UniversityType.find(params[:id])
    end

    def university_type_params
      params.require(:university_type).permit(:name, :code)
    end
  end
end
