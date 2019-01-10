# frozen_string_literal: true

module EnumForTerm
  extend ActiveSupport::Concern

  included do
    # enum
    enum term: {
      fall: 0,
      spring: 1,
      summer: 2
    }

    # validation
    validates :term, inclusion: { in: terms.keys }
  end
end
