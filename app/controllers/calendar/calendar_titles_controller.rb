# frozen_string_literal: true

module Calendar
  class CalendarTitlesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_calendar_title, only: %i[edit update]

    def index
      @calendar_titles = pagy_by_search(CalendarTitle.includes(:types, :calendar_title_types))
    end

    def edit; end

    def update
      @calendar_title.update(calendar_title_params) ? redirect_with('success') : render(:edit)
    end

    private

    def redirect_with(message)
      redirect_to(calendar_titles_path, notice: t(".#{message}"))
    end

    def set_calendar_title
      @calendar_title = CalendarTitle.find(params[:id])
    end

    def calendar_title_params
      params.require(:calendar_title).permit(type_ids: [])
    end
  end
end
