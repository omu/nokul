# frozen_string_literal: true

module Patron
  module SearchableModule
    extend ActiveSupport::Concern
    include Pagy::Backend

    def pagy_by_search(collection, **options)
      options = {
        page_param: :page, pagy_name: :pagy
      }.merge(options)

      term       = params[:term]
      collection = term.present? && collection.respond_to?(:search) ? collection.search(term) : collection
      pagination = pagy(collection, options)

      instance_variable_set("@#{options[:pagy_name]}", pagination.first)
      pagination.last
    end

    def pagy_multi_by_search(collection, page_param: :page)
      term       = params[:term]
      collection = term.present? && collection.respond_to?(:search) ? collection.search(term) : collection
      result     = pagy(collection, page_param: page_param)
      {
        collection: result.last,
        pagy:       result.first
      }
    end
  end
end
