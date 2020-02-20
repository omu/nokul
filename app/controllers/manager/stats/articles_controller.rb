# frozen_string_literal: true

module Manager
  module Stats
    class ArticlesController < ApplicationController
      layout false

      def index
        authorize(current_user, policy_class: Manager::Stats::ArticlePolicy)
      end
    end
  end
end
