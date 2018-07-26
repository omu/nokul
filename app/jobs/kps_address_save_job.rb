# frozen_string_literal: true

class KpsAddressSaveJob < ApplicationJob
  queue_as :high

  # slow operation
  def perform(user)
    @response = Services::Kps::Omu::Adres.new.sorgula(user.id_number.to_i)
  end

  # callbacks
  after_perform do |job|
    district = District.find_by(mernis_code: @response[:district_id])
    formal = job.arguments.first.addresses.formal
    if formal.present?
      formal.update(district: district, full_address: @response[:full_address])
    else
      formal.create(district: district, full_address: @response[:full_address])
    end
  end
end
