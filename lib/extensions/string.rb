class String
  def capitalize_all
    split.map{|word| word.capitalize(:turkic)}.join(' ')
  end

  def abbreviation
    split.map(&:first).join.upcase(:turkic)
  end
end
