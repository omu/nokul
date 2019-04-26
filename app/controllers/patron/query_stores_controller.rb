# frozen_string_literal: true

module Patron
  class QueryStoresController < ApplicationController
    include SearchableModule

    before_action :set_query_store, only: %i[show edit update destroy preview]
    before_action :authorized?

    def index
      @query_stores = pagy_by_search(Patron::QueryStore.order(:name, :scope_name))
    end

    def show; end

    def new
      @query_store = init_query_scope(params[:scope])
    end

    def edit; end

    def create
      @query_store = init_query_scope(query_store_params[:scope_name])
      @query_store.assign_attributes(query_store_params)
      @query_store.save ? redirect_to(@query_store, notice: t('.success')) : render(:new)
    end

    def update
      @query_store.update(query_store_params) ? redirect_to(@query_store, notice: t('.success')) : render(:new)
    end

    def destroy
      if @query_store.destroy
        redirect_to(patron_query_stores_path, notice: t('.success'))
      else
        redirect_to(patron_query_store_path, alert: t('.warning'))
      end
    end

    def preview
      @scope      = @query_store.scope_klass
      @results    = @scope.preview_for_records(@query_store)
      @attributes = @query_store.scope_klass.preview_attributes
      @collection = pagy_by_search(@results)
    end

    private

    def authorized?
      authorize(@role || Patron::QueryStore)
    end

    def init_query_scope(scope_name)
      Patron::QueryStore.new(scope_name: scope_name)
    end

    def set_query_store
      @query_store = Patron::QueryStore.find(params[:id])
    end

    def query_store_params
      @query_store ||= init_query_scope(params[:patron_query_store][:scope_name])

      params.require(:patron_query_store).permit(
        :name, :scope_name, :type, *@query_store.permitted_attributes.to_a
      )
    end
  end
end
