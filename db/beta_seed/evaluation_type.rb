# frozen_string_literal: true

evaluation_types = [
  { name: 'Dönem İçi Değerlendirme' },
  { name: 'Dönem Sonu Değerlendirme' },
  { name: 'Bütünleme Değerlendirme' }
]

EvaluationType.create(evaluation_types)
