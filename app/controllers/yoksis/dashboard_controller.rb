# frozen_string_literal: true

module Yoksis
  class DashboardController < ApplicationController
    def index
      authorize %i[yoksis dashboard]
    end
  end
end
