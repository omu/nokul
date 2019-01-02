# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @address = Rails.configuration.tenant.contact.address
  end
end
