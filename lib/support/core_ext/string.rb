# frozen_string_literal: true

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

  def capitalize_all
    split.map { |word| word.capitalize(:turkic) }.join(' ')
  end

  def upcase_tr
    upcase(:turkic)
  end

  def abbreviation
    split.map(&:first).join.upcase(:turkic)
  end
end
