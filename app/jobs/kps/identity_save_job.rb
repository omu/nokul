# frozen_string_literal: true

module Kps
  class IdentitySaveJob < ApplicationJob
    queue_as :high

    def perform(user)
      @user = user
      IdentityUpsertService.call(@user, response)
    end

    private

    def response
      @response ||= Xokul::Kps::Identity.new(@user.id_number).model_data.merge(type: 'formal')
    end
  end
end
