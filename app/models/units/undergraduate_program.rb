class UndergraduateProgram < ApplicationRecord
  belongs_to :program, polymorphic: true
end

# TODO: active alanı bool değil enum olacak. çok durum var.
# TODO: diyagramda buna direk gelen has_many yok! öyleyse department'a olmamalı.