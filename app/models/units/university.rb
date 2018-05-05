# frozen_string_literal: true

class University < Unit
  # relations
  belongs_to :university_type, optional: true
end
