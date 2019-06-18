# frozen_string_literal: true

require 'test_helper'

# Inspire from: https://github.com/ProctorU/policy-assertions/blob/master/lib/policy_assertions.rb

class PunditTestCase < ActiveSupport::TestCase
  # Usage:
  # asset_permit(
  #   user,
  #   record: units(:one), # required or optional according to the policy
  #   permissions: %i[index? foo?], # is resolved from the name of the test if empty
  #   policy_class: UnitPolicy # is resolved from the class name of the test if empty
  # )
  def assert_permit(user, **options)
    options = {
      assert_method:  :assert,
      assert_message: <<~MSG
        Expected %{policy_class} to grant %{permission}
        on %{record} for user but it didn't
      MSG
    }.merge(options)

    pundit_test(user, options)
  end

  # Usage:
  # asset_not_permit(
  #   user,
  #   record: units(:one)
  # )
  def assert_not_permit(user, **options)
    options = {
      assert_method:  :assert_not,
      assert_message: <<~MSG
        Expected %{policy_class} not to grant %{permission}
        on %{record} for user but it did
      MSG
    }.merge(options)

    pundit_test(user, options)
  end

  private

  # rubocop:disable Metrics/MethodLength
  def pundit_test(user, **options)
    permissions = resolve_permissions(options)
    policy      = policy_instance(user, options)

    permissions.each do |permission|
      public_send(
        options.fetch(:assert_method),
        policy.public_send(permission),
        format(
          options[:assert_message],
          permission:   permission,
          record:       options[:record],
          policy_class: policy.class.name
        )
      )
    end
  end
  # rubocop:enable Metrics/MethodLength

  def policy_instance(user, options)
    options.fetch(:policy_class, policy_class)
           .new(user, options.fetch(:record, nil))
  end

  # test 'index?' do; end => ['index?']
  def resolve_permissions(options)
    [*options.fetch(:permissions, name.delete_prefix('test_'))]
  end

  def policy_class
    class_name.delete_suffix('Test').safe_constantize
  end
end
