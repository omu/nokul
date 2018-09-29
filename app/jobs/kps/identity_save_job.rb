# frozen_string_literal: true

module Kps
  class IdentitySaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user, student_id = nil)
      @student_id = student_id
      @response = Kps::Omu::Kimlik.new.sorgula(user.id_number.to_i)
    end

    # callbacks
    after_perform do |job|
      response = @response.merge(student_id: @student_id, type: 'formal')
      user = job.arguments.first
      formal_identity = user.identities.user_identity
      formal_identity.present? ? formal_identity.update(response) : user.identities.create(response)
    end
  end
end
