# frozen_string_literal: true

module Calendar
  class CalendarTypesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_calendar_type, only: %i[show edit update destroy]

    # GET /calendar_types
    # GET /calendar_types.json
    def index
      @calendar_types = CalendarType.all
    end

    def show
      @titles = @calendar_type.titles
    end

    # GET /calendar_types/new
    def new
      @calendar_type = CalendarType.new
    end

    # GET /calendar_types/1/edit
    def edit; end

    # POST /calendar_types
    # POST /calendar_types.json
    def create
      @calendar_type = CalendarType.new(calendar_type_params)

      respond_to do |format|
        if @calendar_type.save
          format.html { redirect_to calendar_types_url, notice: 'Calendar type was successfully created.' }
          format.json { render :show, status: :created, location: @calendar_type }
        else
          format.html { render :new }
          format.json { render json: @calendar_type.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /calendar_types/1
    # PATCH/PUT /calendar_types/1.json
    def update
      respond_to do |format|
        if @calendar_type.update(calendar_type_params)
          format.html { redirect_to calendar_types_url, notice: 'Calendar type was successfully updated.' }
          format.json { render :show, status: :ok, location: @calendar_type }
        else
          format.html { render :edit }
          format.json { render json: @calendar_type.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /calendar_types/1
    # DELETE /calendar_types/1.json
    def destroy
      @calendar_type.destroy
      respond_to do |format|
        format.html { redirect_to calendar_types_url, notice: 'Calendar type was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_calendar_type
      @calendar_type = CalendarType.find(params[:id])
    end

    def calendar_type_params
      params.require(:calendar_type)
            .permit(:name, calendar_title_types_attributes: %i[id type_id title_id status _destroy])
    end
  end
end
