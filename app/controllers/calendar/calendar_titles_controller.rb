# frozen_string_literal: true

module Calendar
  class CalendarTitlesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_calendar_title, only: %i[edit update destroy]

    # GET /calendar_titles
    # GET /calendar_titles.json
    def index
      @calendar_titles = CalendarTitle.all
    end

    # GET /calendar_titles/new
    def new
      @calendar_title = CalendarTitle.new
    end

    # GET /calendar_titles/1/edit
    def edit; end

    # POST /calendar_titles
    # POST /calendar_titles.json
    def create
      @calendar_title = CalendarTitle.new(calendar_title_params)

      respond_to do |format|
        if @calendar_title.save
          format.html { redirect_to calendar_titles_url, notice: 'Calendar title was successfully created.' }
          format.json { render :show, status: :created, location: @calendar_title }
        else
          format.html { render :new }
          format.json { render json: @calendar_title.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /calendar_titles/1
    # PATCH/PUT /calendar_titles/1.json
    def update
      respond_to do |format|
        if @calendar_title.update(calendar_title_params)
          format.html { redirect_to calendar_titles_url, notice: 'Calendar title was successfully updated.' }
          format.json { render :show, status: :ok, location: @calendar_title }
        else
          format.html { render :edit }
          format.json { render json: @calendar_title.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /calendar_titles/1
    # DELETE /calendar_titles/1.json
    def destroy
      @calendar_title.destroy
      respond_to do |format|
        format.html { redirect_to calendar_titles_url, notice: 'Calendar title was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_calendar_title
      @calendar_title = CalendarTitle.find(params[:id])
    end

    def calendar_title_params
      params.require(:calendar_title).permit(:name)
    end
  end
end
