# frozen_string_literal: true

class RoleManagement
  extend Patron::PermissionBuilder
  extend Patron::RoleBuilder

  # permissions
  permission :role_management,
             name:        'Rol Yönetimi',
             description: 'Rol Yönetim Yetkisi',
             privileges:  %i[read write destroy]
  permission :permission_management,
             name:        'İzin Yönetimi',
             description: 'İzin Yönetim Yetkisi',
             privileges:  %i[read write destroy]
  permission :scope_query_management,
             name:        'Kapsam Sorgu Yönetimi',
             description: 'Kapsam Sorgu Yönetim Yetkisi',
             privileges:  %i[read write destroy]
  permission :authorization_management,
             name:        'Yetkilendirme Yönetimi',
             description: 'Yetkilendirme Yönetimi Yetkisi',
             privileges:  %i[read write destroy]

  # roles
  role :authorization_manager,
       name:        'Yetkilendirme Yöneticisi',
       permissions: {
         role_management:          %i[read write destroy],
         permission_management:    %i[read write destroy],
         scope_query_management:   %i[read write destroy],
         authorization_management: %i[read write destroy]
       }
end
