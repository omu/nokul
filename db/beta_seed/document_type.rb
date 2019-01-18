# frozen_string_literal: true

document_types = [
  {
    name: 'Sağlık Raporu'
  },
  {
    name: 'Özgeçmiş'
  },
  {
    name: 'Nüfus Cüzdanı Fotokopisi'
  },
  {
    name: 'Lisans Transkripti'
  },
  {
    name: 'Geçici Mezuniyet Belgesi'
  },
  {
    name: 'ALES Belgesi'
  },
  {
    name: 'Adli Sicil Kaydı Belgesi'
  }
]

DocumentType.create(document_types)
