# frozen_string_literal: true

class RegulationsController < ApplicationController
  include SearchableModule

  before_action :set_regulation, only: %i[show clause]

  def index
    @pagy, @regulations = pagy(Regulation.all)

    authorize(@regulations)
  end

  def show
    @pagy, @clauses = pagy_array(@regulation.clauses)
  end

  def clause
    render json: @regulation.klass.clauses[params[:identifier].to_sym].to_h
  end

  private

  def set_regulation
    @regulation = Regulation.find(params[:id])

    authorize(@regulation)
  end
end
