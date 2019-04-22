# frozen_string_literal: true

module Patron
  class DashboardController < ApplicationController
    def index
      @counter = {
        roles: Patron::Role.count,
        permissions: Patron::Permission.count,
        query_stores: Patron::QueryStore.count
      }
    end
  end
end
