# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: SETTINGS['email']['default_from']
  layout 'mailer'
end
