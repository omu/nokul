# frozen_string_literal: true

namespace :patron do
  desc 'Upsert permissions'
  task upsert_permissions: :environment do
    Patron::PermissionBuilder.all.each do |identifier, permission|
      record = Patron::Permission.find_or_initialize_by(identifier: identifier)
      record.assign_attributes(permission.to_h)
      record.save
    end

    Patron::Permission.where.not(identifier: Patron::PermissionBuilder.all.keys)
                            .destroy_all
  end

  desc 'Upsert roles'
  task upsert_roles: :environment do
    Patron::RoleBuilder.all.each do |identifier, role|
      permissions        = Patron::Permission.where(identifier: role.permissions.to_a)
      record             = Patron::Role.find_or_initialize_by(identifier: identifier)
      record.locked      = true
      record.permissions = permissions
      record.name        = role.name
      record.save
    end
  end

  desc 'Runs all patron tasks'
  task all: %w[upsert_permissions upsert_roles]
end
