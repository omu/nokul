# frozen_string_literal: true

user = User.new(
  id_number:             11_111_111_111,
  email:                 'cezmi@baum.omu.edu.tr',
  password:              '123456',
  password_confirmation: '123456',
  activated:             true
)

User.skip_callback(:commit, :after, :build_address_information)
User.skip_callback(:commit, :after, :build_identity_information)
user.save(validate: false)
User.after_create_commit :build_address_information
User.after_create_commit :build_identity_information

Identity.create!(
  type:           'informal',
  first_name:     'Cezmi Seha',
  last_name:      'SAHİR',
  mothers_name:   'Bilge',
  fathers_name:   'Emre Can',
  gender:         'male',
  marital_status: 'single',
  place_of_birth: 'Samsun',
  date_of_birth:  Time.zone.now.to_date,
  user_id:        user.id,
  student_id:     nil
)

Address.create!(
  type:         'informal',
  full_address: 'Ondokuz Mayıs Üniversitesi Rektörlük Binası Kurupelit Kampüsü, 55139 Atakum / SAMSUN',
  district_id:  769,
  user_id:      user.id
)

user.roles << Patron::Role.all
