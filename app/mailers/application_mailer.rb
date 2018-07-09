# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@baum.omu.edu.tr'
  layout 'mailer'
end
