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
  permission :curriculum_management,
             name:        'Müfredat Yönetimi',
             description: 'Müfredat Yönetimi Yetkisi',
             privileges:  %i[read write destroy report]
  permission :committee_management,
             name:        'Kurul Yönetimi',
             description: 'Kurul Yönetimi Yetkisi',
             privileges:  %i[read write destroy]
  permission :decision_management,
             name:        'Karar Yönetimi',
             description: 'Karar Yönetimi Yetkisi',
             privileges:  %i[read write destroy]
  permission :agenda_management,
             name:        'Gündem Yönetimi',
             description: 'Gündem Yönetimi Yetkisi',
             privileges:  %i[read write destroy]
  permission :meeting_management,
             name:        'Toplantı Yönetimi',
             description: 'Toplantı Yönetimi Yetkisi',
             privileges:  %i[read write destroy]
  permission :detsis_management,
             name:        'DETSİS Yönetimi',
             description: 'DETSİS Yönetimi Yetkisi',
             privileges:  %i[read write destroy]
  # roles
  role :authorization_manager,
       name:        'Yetkilendirme Yöneticisi',
       permissions: {
         authorization_management: %i[read write destroy],
         permission_management:    %i[read write destroy],
         role_management:          %i[read write destroy],
         scope_query_management:   %i[read write destroy]
       }

  role :admin,
       name:        'Admin',
       permissions: {
         agenda_management:           %i[read write destroy],
         available_course_management: %i[read write destroy report],
         calendar_management:         %i[read write destroy],
         committee_management:        %i[read write destroy],
         course_management:           %i[read write destroy report],
         curriculum_management:       %i[read write destroy report],
         decision_management:         %i[read write destroy],
         detsis_management:           %i[read write destroy],
         meeting_management:          %i[read write destroy]
       }
end
