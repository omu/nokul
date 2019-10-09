# frozen_string_literal: true

module ApaHelper
  def apa_citation(article)
    title = article.title.capitalize_turkish

    "#{authors_in_apa_format(article.authors)}. (#{article.year}). #{title}. #{article.journal}, \
    #{article.volume}(#{article.issue}), #{article.first_page}-#{article.last_page}"
  end

  def book_citation(book)
    "#{authors_in_apa_format(book.authors)}. (#{book.year}). #{book.name.capitalize_turkish}. \
    #{book.city}: #{book.publisher}."
  end

  def book_chapter_citation(book)
    "#{authors_in_apa_format(book.authors)}. (#{book.year}). #{book.chapter_name}. \
    #{authors_in_apa_format(book.editor_name || '')}, #{book.name} \
    (#{t('.page_numbers_abbrev')} #{book.chapter_first_page} - #{book.chapter_last_page}). \
    #{book.city}: #{book.publisher}."
  end

  def authors_in_apa_format(authors)
    authors.split(',').map do |author|
      names = author.split
      last_name = names.shift.capitalize_turkish
      first_name = names.map(&:first).join('. ')
      "#{last_name}, #{first_name}"
    end.join(' & ')
  end

  def user_projects(project)
    concat "#{project.type} - #{project.duty} - \
            #{l(project.start_date, format: '%m - %Y', default: '')} / \
            #{l(project.end_date, format: '%m - %Y', default: '')} | \
            #{t('.status')} : #{enum_t(project, :status)}"
    concat tag.br
    project.subject || project.name
  end
end
