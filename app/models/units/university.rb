class University < Unit
  # Define these functions: faculties, institutes, vocationalschools, academies,
  # departments, sciencedisciplines, artdisciplines, disciplines,
  # interdisciplinarydisciplines, disciplines, rectorships, researchcenters
  (types - %w[University]).each do |type|
    define_method(type.downcase.pluralize) do
      descendants.where(type: type)
    end
  end
end
