# frozen_string_literal: true

module Manager
  module Stats
    class ArticlesController < ApplicationController
      include SearchableModule

      before_action :authorized?

      def index
        articles = Article.active
                          .includes(:user)
                          .order("year DESC NULLS LAST")
                          .dynamic_search(search_params(Article))
        @pagy, @articles = pagy(articles)
      end
      
      def dashboard
        unit_types = UnitType.includes(:units)
                             .where(name: ['Rektörlük', 'Fakülte', 'Meslek Yüksekokulu', 'Yüksekokul', 'Enstitü'])
        @number_of_articles_by_units = Article.active.joins(:units).group('units.names_depth_cache').count
        @number_of_articles_by_base_units =
          unit_types.each_with_object(Hash.new{ |h,k| h[k] = {} }) do |unit_type, hash|
            unit_type.units.each do |unit|
              unit_names = unit.subtree.pluck(:names_depth_cache)
              number_of_articles = @number_of_articles_by_units.values_at(*unit_names).compact.sum
              next if number_of_articles.zero?
              
              hash[unit_type.name][unit.name] = number_of_articles
            end
          end
        render layout: false
      end

      private

      def authorized?
        authorize(current_user, policy_class: Manager::Stats::ArticlePolicy)
      end
    end
  end
end
