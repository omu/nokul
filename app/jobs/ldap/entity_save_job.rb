# frozen_string_literal: true

module Ldap
  class EntitySaveJob < ApplicationJob
    queue_as :high

    def perform(user)
      Ldap::Entity.build(user)
    end
  end
end
