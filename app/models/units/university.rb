class University < Unit
  # Define these functions: faculties, institutes, vocational_schools, academies,
  # departments, science_disciplines, art_disciplines, disciplines,
  # interdisciplinary_disciplines, disciplines, rectorships, research_centers
  (types - %w[University]).each do |type|
    define_method(type.pluralize.underscore) do
      descendants.where(type: type)
    end
  end
end
