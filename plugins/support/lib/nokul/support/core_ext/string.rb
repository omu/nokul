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

  TURKISH_CONJUNCTIONS = %w[
    ama ancak dahi fakat ile lakin ve veya yani
  ].freeze
  private_constant :TURKISH_CONJUNCTIONS

  def titleize_turkish(mappings = {})
    downcase(:turkic).split.map do |word|
      next word if TURKISH_CONJUNCTIONS.include?(word)
      next mappings[word] if mappings.key?(word)

      naked_word = word.sub(/(^[[:punct:]]+|[[:punct:]]+$)/, '')

      if mappings.key?(naked_word)
        word.sub(naked_word, mappings[naked_word])
      else
        word.capitalize(:turkic)
      end
    end.join ' '
  end
end
