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
      model_data = @response.model_data.merge!(type: 'formal')

      model_data[:student_id] = @student_id if @student_id.present?

      user = job.arguments.first
      user_identity = user.identities.user_identity

      if @student_id.present?
        return if user.identities.where(student_id: @student_id).present?

        user.identities.create(model_data)
      else
        user_identity.touch && user_identity.update(model_data) if user_identity.present?
        user.identities.create(model_data) unless user_identity.present?
      end
    end
  end
end
