# frozen_string_literal: true

class PublicProfileController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_employee, only: :show
  before_action :check_identity

  def show; end

  def index; end

  private

  def set_employee
    @employee = Employee.friendly.find(params[:id])
  end

  def check_identity
    identities = @employee.user.identities.formal

    if identities.any?
      @identity = identities.first
    else
      redirect_to root_path
    end
  end
end
