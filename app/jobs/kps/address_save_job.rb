# frozen_string_literal: true

module Kps
  class AddressSaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Kps::Address.new(user.id_number)
    end

    # callbacks
    after_perform do |job|
      model_data = @response.model_data
      address = job.arguments.first.addresses.formal

      address.touch && address.update(model_data) if address.present?
      address.create(model_data) unless address.present?
    end
  end
end
