# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@baum.omu.edu.tr'
  layout 'mailer'
end
