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
        render layout: false
      end

      private

      def authorized?
        authorize(current_user, policy_class: Manager::Stats::ArticlePolicy)
      end
    end
  end
end
