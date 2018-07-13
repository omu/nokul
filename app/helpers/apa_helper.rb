# frozen_string_literal: true

module ApaHelper
  def apa_citation(article)
    title = article.title.capitalize_all

    "#{authors_in_apa_format(article)}. #{title}. #{article.journal}, #{article.volume}(#{article.issue}), \
    #{article.first_page}-#{article.last_page}"
  end

  def authors_in_apa_format(article)
    apa_authors = []

    article.authors.split(',').each do |author|
      last_name = author.split(' ')[0].capitalize_all
      first_name = author.split(' ')[1..-1].map! { |a| a[0] }.join('. ')

      apa_authors << ["#{last_name}, #{first_name}"]
    end

    apa_authors.join(' & ')
  end
end
