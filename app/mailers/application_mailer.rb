# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.tenant.email.default_from
  layout 'mailer'
end
