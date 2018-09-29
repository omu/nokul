# frozen_string_literal: true

class VcardBuilder
  def initialize(identity)
    @identity = identity
  end

  def build_vcard
    <<~VCARD
      BEGIN:VCARD
      VERSION:3.0
      N:#{@identity.last_name};#{@identity.first_name};;;
      FN:#{@identity.first_name} #{@identity.last_name}
      ORG:#{Rails.application.config.tenant.name}
      TITLE:#{@identity.user.title}
      EMAIL:#{@identity.user.email}
      END:VCARD
    VCARD
  end
end
