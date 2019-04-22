# frozen_string_literal: true

module Patron
  class PermissionsController < ApplicationController
    def index
      @permissions = Permission.all
    end

    def show
      @permission = Permission.find(params[:id])
    end
  end
end
