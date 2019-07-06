# frozen_string_literal: true

class LdapEntitiesController < ApplicationController
  include SearchableModule
  before_action :set_ldap_entity, only: %i[show start_sync]

  def index
    entities = LdapEntity.includes(:user).order(created_at: :desc)
    @pagy, @entities = pagy(entities.dynamic_search(params_for_filter))
  end

  def show
    @errors = @entity.ldap_sync_errors
  end

  def start_sync
    @entity.sync
    redirect_to(@entity, notice: t('.success'))
  end

  private

  def set_ldap_entity
    @entity = LdapEntity.find(params[:id])
  end

  def params_for_filter
    filters = search_params(LdapEntity)
    %i[created_at synchronized_at].each do |attribute|
      next unless filters.key?(attribute) && filters[attribute].present?

      dates              = filters[attribute].split(' - ').sort
      filters[attribute] = dates.first..dates.last
    end

    filters
  end
end
