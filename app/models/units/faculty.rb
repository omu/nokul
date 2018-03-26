class Faculty < Unit
  # Define these functions: departments, science_disciplines, art_disciplines
  %w[Department ScienceDiscipline ArtDiscipline].each do |type|
    define_method(type.pluralize.underscore) do
      descendants.where(type: type)
    end
  end
end
