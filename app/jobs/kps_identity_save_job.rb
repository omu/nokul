# frozen_string_literal: true

class KpsIdentitySaveJob < ApplicationJob
  queue_as :high

  # slow operation
  def perform(user, student_id = nil)
    @student_id = student_id
    @response = Services::Kps::Omu::Kimlik.new.sorgula(user.id_number.to_i)
  end

  # callbacks
  after_perform do |job|
    response = @response.merge(student_id: @student_id)
    formal_address = job.arguments.first.identities.formal
    formal_address.present? ? formal_address.update(response) : formal_address.create(response)
  end
end
