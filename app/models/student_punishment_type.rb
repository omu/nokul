# frozen_string_literal: true

class StudentPunishmentType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations
end
