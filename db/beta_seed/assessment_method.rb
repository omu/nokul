# frozen_string_literal: true

assessment_methods = [
  { name: 'Sınav' },
  { name: 'Uygulama' },
  { name: 'Laboratuvar' },
  { name: 'Proje' },
  { name: 'Ödev' },
  { name: 'Arazi Çalışması' },
  { name: 'Ürün Dosyası' }
]

AssessmentMethod.create(assessment_methods)
