# frozen_string_literal: true

module ApaHelper
  def apa_citation(article)
    title = article.title.capitalize_turkish

    "#{authors_in_apa_format(article)}. (#{article.year}). #{title}. #{article.journal}, \
    #{article.volume}(#{article.issue}), #{article.first_page}-#{article.last_page}"
  end

  def authors_in_apa_format(article)
    article.authors.split(',').map do |author|
      names = author.split
      last_name = names.shift.capitalize_turkish
      first_name = names.map(&:first).join('. ')
      "#{last_name}, #{first_name}"
    end.join(' & ')
  end
end
