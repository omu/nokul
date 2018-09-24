# frozen_string_literal: true

module Yoksis
  class ProjectsCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Yoksis::V1::Ozgecmis.new(user.id_number.to_i).projects
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first
      if @response[:sonuc][:durum_kodu].eql?('1') && @response[:proje_listesi].present?
        response = [@response[:proje_listesi]].flatten

        response.each do |study|
          user.projects.create(
            yoksis_id: study[:proje_id].try(:to_i),
            name: study[:proje_ad],
            subject: study[:proje_konusu],
            status: study[:proje_durumu_id].try(:to_i),
            bastar: study[:bas_tar],
            bittar: study[:bit_tar],
            budget: study[:butce],
            duty: study[:proje_konumu_ad],
            type: study[:proje_turu_ad],
            currency: study[:para_birimi_ad],
            last_update: study[:guncelleme_tarihi],
            activity: study[:aktif_pasif].try(:to_i),
            scope: study[:kapsam].try(:to_i),
            title: study[:unvan_ad],
            unit_id: study[:kurum_id].try(:to_i),
            incentive_point: study[:tesv_puan]
          )
        end
      end
    end
  end
end
