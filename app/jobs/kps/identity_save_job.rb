# frozen_string_literal: true

module Kps
  class IdentitySaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user, student_id = nil)
      @user = user
      @student_id = student_id
      @response = Xokul::Kps::Identity.new(@user.id_number)
    end

    # callbacks
    after_perform do
      model_data = @response.model_data.merge!(type: 'formal')
      user_identity = @user.identities.user_identity
      student_identity = @user.identities.where(student_id: @student_id)

      if @student_id.present?
        model_data = model_data.merge(student_id: @student_id)
        return if student_identity.present?

        @user.identities.create(model_data)
      else
        user_identity.present? ? user_identity.update(model_data) : @user.identities.create(model_data)
      end
    end
  end
end
