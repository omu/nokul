# frozen_string_literal: true

class KpsIdentityCreateOrUpdateJob < ApplicationJob
  queue_as :high

  # slow operation
  def perform(user, student_id = nil)
    @user = user
    @student_id = student_id
    @response = Services::Kps::Omu::Kimlik.new.sorgula(user.id_number.to_i)
  end

  # callbacks
  after_perform do |_job|
    data = @response.merge(student_id: @student_id)
    formal = @user.identities.formal
    # Eğer kişinin formal kimliği varsa; kimlik bilgilerini güncelle, yoksa formal kimlik oluştur.
    formal.present? ? formal.update(data) : formal.create(data)
  end
end
