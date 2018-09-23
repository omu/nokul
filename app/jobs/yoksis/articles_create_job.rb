# frozen_string_literal: true

module Yoksis
  class ArticlesCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Yoksis::V1::Ozgecmis.new(user.id_number.to_i).articles
    end

    # callbacks
    # rubocop:disable Metrics/BlockLength
    after_perform do |job|
      user = job.arguments.first
      if @response[:sonuc][:durum_kodu].eql?('1') && @response[:makale_liste].present?
        response = [@response[:makale_liste]].flatten

        response.each do |study|
          user.articles.create(
            yoksis_id: study[:yayin_id],
            scope: study[:kapsam_id].try(:to_i),
            review: study[:hakem_tur].try(:to_i),
            index: study[:endeks_id].try(:to_i),
            title: study[:makale_adi],
            authors: study[:yazar_adi],
            number_of_authors: study[:yazar_sayisi],
            country: study[:ulke],
            city: study[:sehir],
            journal: study[:dergi_adi],
            language_of_publication: study[:yayin_dili_adi],
            month: study[:ay],
            year: study[:yil],
            volume: study[:cilt],
            issue: study[:sayi],
            first_page: study[:ilk_sayfa],
            last_page: study[:son_sayfa],
            doi: study[:doi],
            issn: study[:issn],
            access_type: study[:erisim_turu].try(:to_i),
            access_link: study[:erisim_linki],
            discipline: study[:alan_bilgisi],
            keyword: study[:anahtar_kelime],
            special_issue: study[:ozel_sayi],
            special_issue_name: study[:ozel_sayi_ad],
            sponsored_by: study[:sponsor],
            author_id: study[:yazar_id],
            last_update: study[:guncelleme_tarihi],
            status: study[:aktif_pasif].try(:to_i),
            type: study[:makale_turu_id].try(:to_i),
            incentive_point: study[:tesv_puan]
          )
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
