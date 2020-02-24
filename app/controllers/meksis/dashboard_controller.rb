# frozen_string_literal: true

module Meksis
  class DashboardController < ApplicationController
    def index
      authorize %i[meksis dashboard]
    end
  end
end
