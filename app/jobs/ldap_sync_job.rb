# frozen_string_literal: true

class LdapSyncJob < ApplicationJob
  queue_as :high

  def perform(*args)
    # Do something later
  end
end
