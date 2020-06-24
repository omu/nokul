# frozen_string_literal: true

module Clauses
  module V1
    class SelectableAdditionalEcts < Extensions::Regulation::Clause
      identifier   :selectable_additional_ects
      register     ::V1::UndergraduateRegulation, metadata: {
        version:     30_911,
        number:      10,
        paragraph:   [7, 8, 9, 10, 11],
        store:       :default,
        description: <<~TEXT.squish
          <strong>(7)</strong> GANO’su 1,80-2,49 arası olan öğrenciler, öncelikle başarısız oldukları veya alamadıkları alt
          dönem derslerini alırlar. Bu öğrenciler devam alıp başarısız oldukları dersler dahil dönemdeki AKTS
          kredi toplamını en fazla 6 (altı) AKTS kredisi kadar artırabilirler.
          <br><br><strong>(8)</strong> GANO’su 2,50-2,99 arası olan öğrenciler, öncelikle başarısız oldukları veya alamadıkları alt
          dönem derslerini alırlar. Bu öğrenciler devam alıp başarısız oldukları dersler dahil dönemdeki AKTS
          kredi toplamını en fazla 10 (on) AKTS kredisi kadar artırabilirler.
          <br><br><strong>(9)</strong> GANO’su 3,00-3,49 arası olan öğrenciler, öncelikle başarısız oldukları veya alamadıkları alt
          dönem derslerini almak şartıyla devam alıp başarısız oldukları dersler dahil dönemdeki AKTS kredi
          toplamını en fazla 12 (on iki) AKTS kredisi artırabilirler.
          <br><br><strong>(10)</strong> GANO’su 3,50 ve üzerinde olan öğrenciler, bir üst yıl/dönemden dönemdeki AKTS
          kredisini, öncelikle başarısız oldukları veya alamadıkları alt dönem derslerini almak şartıyla en fazla
          15 (on beş) AKTS kredisi artırarak öğrenimlerini daha kısa sürede tamamlayabilirler.
          <br><br><strong>(11)</strong> Yedinci, sekizinci, dokuzuncu ve onuncu fıkralarda yer alan AKTS kredisi değerleri, yıllık
          program uygulayan birimlerde iki katı olarak uygulanır.
        TEXT
      }

      store do
        {
          1.8 => 6,
          2.5 => 10,
          3   => 12,
          3.5 => 15
        }
      end

      attributes :student

      def call
        ects = 0

        store.each do |key, value|
          ects = value if key <= student.gpa
        end

        ects *= 2 if student.unit.semester_type == 'yearly'

        ects
      end
    end
  end
end
