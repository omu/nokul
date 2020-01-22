# frozen_string_literal: true

namespace :patron do
  desc 'Upsert permissions'
  task upsert_permissions: :environment do
    Patron::PermissionBuilder.all.each do |identifier, permission|
      record = Patron::Permission.find_or_initialize_by(identifier: identifier)
      record.assign_attributes(
        permission.to_h.slice(*Patron::Permission.attribute_names.map(&:to_sym))
      )
      record.save
    end

    Patron::Permission.where.not(identifier: Patron::PermissionBuilder.all.keys)
                      .destroy_all
  end

  desc 'Upsert roles'
  task upsert_roles: :environment do
    Patron::RoleBuilder.all.each do |identifier, role|
      record        = Patron::Role.find_or_initialize_by(identifier: identifier)
      record.locked = true
      record.name   = role.name
      record.role_permissions = role.permissions.map do |key, privileges|
        record.role_permissions.build(
          permission_id: Patron::Permission.find_by(identifier: key).id,
          privileges:    privileges
        )
      end
      record.save!
    end
  end

  desc 'Runs all patron tasks'
  task all: %w[upsert_permissions upsert_roles]
end
