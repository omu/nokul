# frozen_string_literal: true

class StudentPunishmentType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
end
