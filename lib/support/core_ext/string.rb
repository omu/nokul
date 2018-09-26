# frozen_string_literal: true

class String
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
