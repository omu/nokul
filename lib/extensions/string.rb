class String
  def capitalize_all
    split.map { |word| word.capitalize(:turkic) }.join(' ')
  end

  def abbreviation
    split.map(&:first).join.upcase(:turkic)
  end

  def underscore
    gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
  end
end
