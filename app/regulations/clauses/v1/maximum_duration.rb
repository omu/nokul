# frozen_string_literal: true

module Clauses
  module V1
    class MaximumDuration < Extensions::Regulation::Clause
      identifier   :maximum_duration_of_education
      register     ::V1::UndergraduateRegulation, metadata: {
        version:     30_911,
        number:      8,
        paragraph:   1,
        store:       :default,
        description: <<~TEXT.squish
          Ön lisans ve lisans düzeyinde öğrenim gören öğrencilerin öğrenimlerini
          tamamlamaları için tanınan azami süreler; bir yıl süreli yabancı dil hazırlık sınıfı hariç kayıt olduğu
          programa ait derslerin verildiği dönemden başlamak üzere her dönem için kayıt yaptırıp
          yaptırmadığına bakılmaksızın, iki yıllık ön lisans programları için dört, dört yıllık lisans programları
          için yedi, eğitim-öğretim süresi (Değişik ibare:RG-14/7/2019-30831) beş yıl olanlar için sekiz ve altı
          yıl olan programlar için dokuz yıldır. Azami süreyi aşan öğrencilerin, ders, uygulama, staj, sınavlara
          katılma hariç öğrencilere tanınan diğer haklardan yararlandırılmaksızın öğrencilik statüleri devam
          eder.
        TEXT
      }

      store do
        {
          2 => 4,
          4 => 7,
          5 => 8,
          6 => 9
        }
      end

      attributes :program

      def call
        raise ArgumentError, 'unit must be of the program type' unless program.program?

        store.fetch(program.duration)
      end
    end
  end
end
