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
      response = @response.merge(student_id: @student_id)
      formal_identity = job.arguments.first.identities.user_identity
      formal_identity.present? ? formal_identity.update(response) : formal_identity.create(response)
    end
  end
end
