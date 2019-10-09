# frozen_string_literal: true

class UserDecorator < SimpleDelegator
  def can_create_identity?
    identities.formal.blank?
  end
end
