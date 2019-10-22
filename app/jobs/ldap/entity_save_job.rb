# frozen_string_literal: true

module LDAP
  class EntitySaveJob < ApplicationJob
    queue_as :high

    def perform(user)
      LDAP::Entity.create(user)
    end
  end
end
