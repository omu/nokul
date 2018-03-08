class Department < ApplicationRecord
  belongs_to :unit, polymorphic: true
  has_many :undergraduate_programs, as: :program
end
# TODO: active alanı bool değil enum olacak. çok durum var.
# TODO: direk üniversite altında bölümler de varmış!!!