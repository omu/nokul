# frozen_string_literal: true

class PublicProfileController < ApplicationController
  include SearchableModule

  skip_before_action :authenticate_user!
  before_action :set_user, only: %i[show vcard]
  before_action :set_employee, only: %i[show vcard]
  before_action :check_identity, only: %i[show vcard]

  def show; end

  def index
    @users = User.joins(:employees).search(params[:term])
  end

  def vcard
    send_data VcardBuilderService.new(@identity).generate, type: 'text/vcard; charset=utf-8; header=present',
                                                           filename: 'contact.vcf'
  end

  private

  def set_user
    @user = User.includes(:articles, duties: [:unit]).friendly.find(params[:id])
  end

  def set_employee
    @employee = @user.employees.includes(:title, positions: [:administrative_function]).active.first
    not_found unless @employee
  end

  def check_identity
    @identity = @user.identities.user_identity
    not_found if @identity.blank?
  end
end
