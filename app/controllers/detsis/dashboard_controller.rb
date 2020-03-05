# frozen_string_literal: true

module Detsis
  class DashboardController < ApplicationController
    def index
      authorize %i[detsis dashboard]
    end
  end
end
