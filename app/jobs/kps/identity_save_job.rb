# frozen_string_literal: true

module Kps
  class IdentitySaveJob < ApplicationJob
    queue_as :high

    def perform(user)
      @user = user
      Identity.transaction do
        updatable? ? @user.identity.update!(response) : @user.identities.create!(response)
      end
    end

    private

    def response
      @response ||= Xokul::Kps::Identity.new(@user.id_number).model_data.merge(
        type: 'formal'
      )
    end

    def eql?(str1, str2)
      str1.to_s.asciified.casecmp?(str2.to_s.asciified)
    end

    def updateable?
      identity = @user.identity

      identity.present? &&
        eql?(identity.first_name, response[:first_name]) &&
        eql?(identity.last_name, response[:last_name])
    end
  end
end
