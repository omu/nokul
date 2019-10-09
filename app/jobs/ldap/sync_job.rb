# frozen_string_literal: true

module LDAP
  class SyncJob < ApplicationJob
    queue_as :high

    def perform(entity)
      LDAP::Client.create_or_update(entity)
      entity.update(status: :synchronized)
      entity.ldap_sync_errors.update(resolved: true)
    rescue LDAP::Client::Error => e
      entity.update(status: :failed)
      entity.ldap_sync_errors.create(description: e.message)
    end
  end
end
