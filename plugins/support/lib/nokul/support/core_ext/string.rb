# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class String
  CHARS = {
    'ı' => 'i',
    'ğ' => 'g',
    'ü' => 'u',
    'ş' => 's',
    'ö' => 'o',
    'ç' => 'c',
    'İ' => 'I',
    'Ğ' => 'G',
    'Ü' => 'U',
    'Ş' => 'S',
    'Ö' => 'O',
    'Ç' => 'C'
  }.freeze

  RE = Regexp.new '[' + CHARS.keys.join + ']'

  def asciified
    gsub(RE) { |char| CHARS[char] }
  end

  def abbreviation
    split.map(&:first).join.upcase(:turkic)
  end

  TURKISH_ABBREVIATIONS = %w[
    ab
    abd
    abitur
    act
    aihm
    ales
    aselsan
    baum
    cmk
    cmuk
    dgs
    gata
    gce
    khk
    kktc
    kpds
    kpss
    les
    meb
    myo
    omü
    ömss
    öss
    ösym
    ösys
    öyp
    sat
    tbmm
    tck
    todaie
    toefl
    trt
    tsk
    tübitak
    uzem
    üds
    yds
    ydus
    ygs
    yök
    yös
  ].freeze

  TURKISH_CONJUNCTIONS = %w[
    ama
    çünkü
    fakat
    hele
    hem
    ile
    ise
    ki
    oysa
    oysaki
    ve
    veya
    veyahut
  ].freeze

  def capitalize_turkish
    downcase(:turkic).split.map do |word|
      if TURKISH_ABBREVIATIONS.include? word
        word.upcase(:turkic)
      elsif TURKISH_CONJUNCTIONS.include? word
        word
      else
        word.capitalize(:turkic)
      end
    end.join(' ')
  end

  # rubocop:disable Metrics/MethodLength
  def capitalize_turkish_with_paranthesised
    # Regex stolen from https://stackoverflow.com/a/6331667
    re = /
      (?<re>
        \(
          (?:
            (?> [^()]+ )
            |
            \g<re>
          )*
        \)
      )
    /x
    capitalize_turkish.gsub re do |match|
      '(' + match[1..-2].capitalize_turkish + ')'
    end
  end
  # rubocop:enable Metrics/MethodLength
end
# rubocop:enable Metrics/ClassLength
