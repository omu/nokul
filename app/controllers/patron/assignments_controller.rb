# frozen_string_literal: true

module Patron
  class AssignmentsController < ApplicationController
    include Pagy::Backend

    def index
      @pagy_for_roles, @roles = pagy_by_search(
        Patron::Role.order(:name),
        page_param: 'page_for_role'
      )

      @pagy_for_query_stores, @query_stores = pagy_by_search(
        Patron::QueryStore.order(:name),
        page_param: 'page_for_query_store'
      )
    end

    private

    def pagy_by_search(collection, page_param:)
      records = (term = params[:term]).present? ? collection.search(term) : collection
      pagy(records, page_param: page_param)
    end
  end
end
