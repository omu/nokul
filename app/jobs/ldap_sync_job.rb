# frozen_string_literal: true

class LdapSyncJob < ApplicationJob
  queue_as :high

  def perform(entity)
    if Ldap::Client.create(entity)
      entity.update(synchronized_at: Time.current, status: :success)
      entity.ldap_sync_errors.update(resolved: true)
    else
      entity.update(status: :fail)
      entity.ldap_sync_errors.create(description: Ldap::Client.results.message)
    end
  end
end
