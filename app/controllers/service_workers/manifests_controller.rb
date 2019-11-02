# frozen_string_literal: true

module ServiceWorkers
  class ManifestsController < ApplicationController
    skip_before_action :authenticate_user!

    def index; end
  end
end
