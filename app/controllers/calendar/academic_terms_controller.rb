# frozen_string_literal: true

module Calendar
  class AcademicTermsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_academic_term, only: %i[edit update destroy]

    # GET /academic_terms
    # GET /academic_terms.json
    def index
      @academic_terms = AcademicTerm.all
    end

    # GET /academic_terms/new
    def new
      @academic_term = AcademicTerm.new
    end

    # GET /academic_terms/1/edit
    def edit; end

    # POST /academic_terms
    # POST /academic_terms.json
    def create
      @academic_term = AcademicTerm.new(academic_term_params)

      respond_to do |format|
        if @academic_term.save
          format.html { redirect_to academic_terms_url notice: 'Academic term was successfully created.' }
          format.json { render :show, status: :created, location: @academic_term }
        else
          format.html { render :new }
          format.json { render json: @academic_term.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /academic_terms/1
    # PATCH/PUT /academic_terms/1.json
    def update
      respond_to do |format|
        if @academic_term.update(academic_term_params)
          format.html { redirect_to academic_terms_url, notice: 'Academic term was successfully updated.' }
          format.json { render :show, status: :ok, location: @academic_term }
        else
          format.html { render :edit }
          format.json { render json: @academic_term.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /academic_terms/1
    # DELETE /academic_terms/1.json
    def destroy
      @academic_term.destroy
      respond_to do |format|
        format.html { redirect_to academic_terms_url, notice: 'Academic term was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_academic_term
      @academic_term = AcademicTerm.find(params[:id])
    end

    def academic_term_params
      params.require(:academic_term).permit(:year, :term)
    end
  end
end
