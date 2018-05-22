# frozen_string_literal: true

class KpsIdentityCreateJob < ApplicationJob
  queue_as :high

  # slow operation
  def perform(user, student_id = nil)
    @user = user
    @student_id = student_id
    @response = Services::Kps::Omu::Kimlik.new.sorgula(user.id_number.to_i)
  end

  # callbacks
  after_perform do |_job|
    @user.identities.formal.create(@response.merge(student_id: @student_id))
  end
end
