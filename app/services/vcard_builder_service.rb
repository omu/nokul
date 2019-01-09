# frozen_string_literal: true

class VcardBuilderService
  def initialize(identity)
    @identity = identity
  end

  def generate
    <<~VCARD
      BEGIN:VCARD
      VERSION:3.0
      N:#{@identity.last_name};#{@identity.first_name};;;
      FN:#{@identity.first_name} #{@identity.last_name}
      ORG:#{Tenant.configuration.tenant.name}
      TITLE:#{@identity.user.title}
      EMAIL:#{@identity.user.email}
      END:VCARD
    VCARD
  end
end
