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
  permission :calendar_management,
             name:        'Takvim Yönetimi',
             description: 'Takvim Yönetimi Yetkisi',
             privileges:  %i[read write destroy]
  permission :course_management,
             name:        'Ders Yönetimi',
             description: 'Ders Yönetimi Yetkisi',
             privileges:  %i[read write destroy report]
  permission :available_course_management,
             name:        'Açılan Ders Yönetimi',
             description: 'Açılan Ders Yönetimi Yetkisi',
             privileges:  %i[read write destroy report]
  # roles
  role :authorization_manager,
       name:        'Yetkilendirme Yöneticisi',
       permissions: {
         role_management:          %i[read write destroy],
         permission_management:    %i[read write destroy],
         scope_query_management:   %i[read write destroy],
         authorization_management: %i[read write destroy]
       }

  role :admin,
       name:        'Admin',
       permissions: {
         calendar_management:         %i[read write destroy],
         course_management:           %i[read write destroy report],
         available_course_management: %i[read write destroy report]
       }
end
