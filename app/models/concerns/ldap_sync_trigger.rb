# frozen_string_literal: true

module LdapSyncTrigger
  extend ActiveSupport::Concern

  class LdapTrigger
    def initialize(user_finder_method)
      @user_finder_method = user_finder_method
    end

    def after_commit(record)
      if record.destroyed? && record.class.name == 'User'
        if Ldap::Client.active?
          Ldap::Client.destroy(Ldap::Entity.new(user(record)))
        else
          Rollbar.log('error', 'LDAP Service unavailable or authentication failed')
        end
      else
        Ldap::EntitySaveJob.perform_later(user(record))
      end
    end

    private

    attr_reader :user_finder_method

    def user(record)
      @user ||= case user_finder_method
                when Proc  then user_finder_method.call(record)
                when :self then record
                else            record.public_send(user_finder_method)
                end
    end
  end

  class_methods do
    def ldap_sync_trigger(method, attributes: [])
      @ldap_sync_trigger_configuration = {
        method: method, attributes: attributes
      }

      after_destroy_commit LdapTrigger.new(method)

      after_save_commit LdapTrigger.new(method), if: -> {
        attributes.blank? || attributes.any? { |key| previous_changes.include?(key) }
      }
    end

    def ldap_sync_trigger_configuration
      @ldap_sync_trigger_configuration ||= {}
    end
  end
end
