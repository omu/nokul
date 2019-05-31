# frozen_string_literal: true

class LdapSyncJob < ApplicationJob
  queue_as :high

  def perform(entity)
    Ldap::Client.create_or_update(entity)
    entity.update(status: :synchronized)
    entity.ldap_sync_errors.update(resolved: true)
  rescue Ldap::Client::Error => e
    entity.update(status: :failed)
    entity.ldap_sync_errors.create(description: e.message)
  end
end
