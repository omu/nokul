# frozen_string_literal: true

module Admin
  class TitlesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_title, only: %i[edit update destroy]

    def index
      @titles = pagy_by_search(Title.order(:name))
    end

    def new
      @title = Title.new
    end

    def create
      @title = Title.new(title_params)
      @title.save ? redirect_to([:admin, 'titles'], notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @title.update(title_params) ? redirect_to([:admin, 'titles'], notice: t('.success')) : render(:edit)
    end

    def destroy
      if @title.destroy
        redirect_to([:admin, 'titles'], notice: t('.success'))
      else
        redirect_to([:admin, 'titles'], alert: t('.warning'))
      end
    end

    private

    def set_title
      @title = Title.find(params[:id])
    end

    def title_params
      params.require(:title).permit(:name, :code, :branch)
    end
  end
end
