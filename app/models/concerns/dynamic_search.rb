# frozen_string_literal: true

module DynamicSearch
  extend ActiveSupport::Concern

  class_methods do
    def search_keys(*keys)
      @dynamic_search_keys = keys.flatten
    end

    def dynamic_search_keys
      raise ArgumentError, 'must be defined in search_keys' unless @dynamic_search_keys
      @dynamic_search_keys
    end

    def dynamic_search(params = {})
      raise ArgumentError, 'parameter must be Hash' unless [ActionController::Parameters, Hash].include?(params.class)
      return search(params[:term]) if params[:term].present?
      query = build_search_query(params)
      query.present? ? where(query) : current_scope
    end

    private

    def build_search_query(params)
      dynamic_search_keys.each_with_object({}) do |key, hash|
        hash[key] = params[key] if params.key?(key) && params[key].present?
      end
    end
  end
end
