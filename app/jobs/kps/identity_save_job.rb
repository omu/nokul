# frozen_string_literal: true

module Kps
  class IdentitySaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user, student_id = nil)
      @student_id = student_id
      @response = Xokul::Kps::Identity.new(user.id_number)
    end

    # callbacks
    after_perform do |job|
      model_data = @response.model_data.merge(student_id: @student_id, type: 'formal')
      user = job.arguments.first
      formal_identity = user.identities.user_identity
      formal_identity.present? ? formal_identity.update(model_data) : user.identities.create(model_data)
    end
  end
end
