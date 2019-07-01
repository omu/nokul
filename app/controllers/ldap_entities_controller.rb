# frozen_string_literal: true

class LdapEntitiesController < ApplicationController
  include SearchableModule

  def index
    @entities = pagy_by_search(LdapEntity.includes(:user).order(created_at: :desc))
  end

  def show
    @entity = LdapEntity.find(params[:id])
    @errors = @entity.ldap_sync_errors
  end
end
