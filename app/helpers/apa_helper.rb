# frozen_string_literal: true

module ApaHelper
  def article_citation(article)
    <<~TEXT.strip.squish
      #{authors_in_apa_format(article.authors)}.
      (#{article.year}).
      #{article.title.capitalize_turkish}.
      #{article.journal},
      #{article.volume}(#{article.issue}),
      #{article.first_page}-#{article.last_page}
    TEXT
  end

  def book_citation(book)
    <<~TEXT.strip.squish
      #{authors_in_apa_format(book.authors)}.
      (#{book.year}).
      #{book.name.capitalize_turkish}.
      #{[book.city, book.publisher].compact.join(': ')}.
    TEXT
  end

  def book_chapter_citation(book)
    <<~TEXT.strip.squish
      #{authors_in_apa_format(book.authors)}.
      (#{book.year}).
      #{book.chapter_name}.
      #{authors_in_apa_format(book.editor_name || '')}, #{book.name}
      (#{t('.page_numbers_abbrev')} #{book.chapter_first_page} - #{book.chapter_last_page}).
      #{[book.city, book.publisher].compact.join(': ')}.
    TEXT
  end

  def authors_in_apa_format(authors)
    authors.split(',').map do |author|
      names = author.split
      last_name = names.shift.capitalize_turkish
      first_name = names.map(&:first).join('. ')
      "#{last_name}, #{first_name}"
    end.join(' & ')
  end
end
