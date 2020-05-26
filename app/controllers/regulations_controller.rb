# frozen_string_literal: true

class RegulationsController < ApplicationController
  include SearchableModule

  def index
    @pagy, @regulations = pagy(Regulation.all)

    authorize(@regulations)
  end

  def show
    @regulation = Regulation.find(params[:id])

    authorize(@regulation)

    @pagy, @clauses = pagy_array(@regulation.clauses)
  end
end
