# frozen_string_literal: true

class PublicProfileController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user, only: %i[show vcard]
  before_action :set_employee, only: %i[show vcard]
  before_action :check_identity, only: %i[show vcard]

  def show; end

  def index; end

  def vcard
    send_data vcard_content(@identity), type: 'text/vcard; charset=utf-8; header=present', filename: 'contact.vcf'
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
    not_found unless @user
  end

  def set_employee
    @employee = @user.employees.active.first
    not_found unless @employee
  end

  def check_identity
    @identity = @user.identities.user_identity
    not_found unless @identity
  end

  def vcard_content(identity)
    <<~VCARD
      BEGIN:VCARD
      VERSION:3.0
      N:#{identity.last_name};#{identity.first_name};;;
      FN:#{identity.first_name} #{identity.last_name}
      ORG:Ondokuz Mayıs Üniversitesi
      TITLE:#{identity.user.title}
      TEL;TYPE=WORK,VOICE:+90 (362) 312-1919
      EMAIL:#{identity.user.email}
      END:VCARD
    VCARD
  end
end
