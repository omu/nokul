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

  TURKISH_CONJUNCTIONS = %w[ama ancak fakat ve veya yani].freeze

  def titleize_tr
    split.map do |word|
      downcased = word.downcase :turkic
      next downcased if downcased.in?(TURKISH_CONJUNCTIONS)

      word.capitalize(:turkic).gsub(/\b(?<!\w['’`])[a-zığüşöç]/) do |match|
        match.capitalize :turkic
      end
    end.join ' '
  end

  def upcase_tr
    upcase(:turkic)
  end

  def abbreviation
    split.map(&:first).join.upcase(:turkic)
  end
end
