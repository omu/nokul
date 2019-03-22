# frozen_string_literal: true

module ContinentHelper
  def continents
    %w[Afrika Antarktika Asya Avrupa Avusturalya Güney\ Amerika Kuzey\ Amerika]
  end

  def regions
    %w[Afrika Amerika Asya Avrupa Okyanusya]
  end

  # rubocop:disable Metrics/MethodLength
  def subregions
    %w[
      Avusturalya\ ve\ Yeni\ Zellanda
      Batı\ Afrika
      Batı\ Asya
      Batı\ Avrupa
      Doğu\ Afrika
      Doğu\ Asya
      Doğu\ Avrupa
      Güney\ Afrika
      Güney\ Amerika
      Güney\ Asya
      Güney\ Avrupa
      Güneydoğu\ Asya
      Karayipler
      Kuzey\ Afrika
      Kuzey\ Amerika
      Kuzey\ Avrupa
      Melanezya
      Mikronezya
      Orta\ Afrika
      Orta\ Amerika
      Orta\ Asya
      Polinezya
    ]
  end
  # rubocop:enable Metrics/MethodLength
end
