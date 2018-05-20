# frozen_string_literal: true

class KpsAddressUpdateJob < ApplicationJob
  queue_as :low

  # slow operation
  def perform(address)
    @params = Services::Kps::Omu::Adres.new.sorgula(address.id_number.to_i)
  end

  # callbacks
  after_perform do |job|
    district = District.find_by(yoksis_id: @params[:district_id])
    job.arguments.first.update(district: district, name: :formal, full_address: @params[:full_address])
  end
end
