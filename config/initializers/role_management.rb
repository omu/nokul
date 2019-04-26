# frozen_string_literal: true

class RoleManagement
  extend Patron::PermissionBuilder
  extend Patron::RoleBuilder

  # permissions
  permission :role_management,
             name: 'Rol Yönetimi',
             description: 'Rol Yönetim Yetkisi'
  permission :permission_management,
             name: 'İzin Yönetimi',
             description: 'İzin Yönetim Yetkisi'
  permission :scope_query_management,
             name: 'Kampam Sorgu Yönetimi',
             description: 'Kampam Sorgu Yönetim Yetkisi'
  permission :authorization_management,
             name: 'Yetkilendirme Yönetimi',
             description: 'Yetkilendirme Yönetimi Yetkisi'

  # roles
  role :authorization_manager,
       name: 'Yetkilendirme Yöneticisi',
       permissions: %i[
         role_management permission_management scope_query_management authorization_management
       ]
end
