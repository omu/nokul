module UniversityType
  extend ActiveSupport::Concern

  included do
    enum university_type: %w(state foundation)
  end
end