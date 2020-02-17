# frozen_string_literal: true

module Manager
  class DashboardController < ApplicationController
    def stats
      authorize(current_user, policy_class: Manager::DashboardPolicy)
    end
  end
end
