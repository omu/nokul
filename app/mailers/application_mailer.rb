# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Nokul::Tenant.configuration.email.default_from
  layout 'mailer'
end
