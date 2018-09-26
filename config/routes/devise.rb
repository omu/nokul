# frozen_string_literal: true

devise_for :users, path_prefix: 'devise', controllers: {
  registrations: 'user/registrations',
  passwords: 'user/passwords',
  sessions: 'user/sessions'
}
