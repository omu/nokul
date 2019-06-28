# frozen_string_literal: true

class LdapEntitiesController < ApplicationController
  include SearchableModule

  def index
    @pagy, @entities = pagy(
      LdapEntity.includes(:user).order(created_at: :desc)
    )
  end

  def show
    @entity = LdapEntity.find(params[:id])
  end
end
