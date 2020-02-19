# frozen_string_literal: true

module Reference
  class DashboardController < ApplicationController
    def index
      authorize %i[reference dashboard]
    end
  end
end
