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

  def user_projects(project)
    concat "#{project.type} - #{project.duty} - \
            #{project.start_date ? l(project.start_date, format: '%Y / %m') : ''} - \
            #{project.end_date ? l(project.end_date, format: '%Y') : ''} | \
            #{t('.status')} : #{enum_t(project, :status)}"
    concat tag.br
    project.name
  end

  def user_certifications(certificate)
    "#{certificate.name} - #{enum_t(certificate, :scope)}, #{enum_t(certificate, :type)} - \
    #{certificate.city_and_country} - (#{l(certificate.start_date, format: '%Y')})"
  end
end
