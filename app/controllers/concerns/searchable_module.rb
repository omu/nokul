# frozen_string_literal: true

module SearchableModule
  extend ActiveSupport::Concern
  include Pagy::Backend

  def pagy_by_search(collection)
    @pagy, items = pagy((term = params[:term]).present? ? collection.search(term) : collection)
    items
  end
end
