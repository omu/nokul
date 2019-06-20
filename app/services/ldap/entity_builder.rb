# frozen_string_literal: true

module Ldap
  class EntityBuilder
    OBJECT_CLASSES = %w[
      person
      organizationalPerson
      inetOrgPerson
      eduPerson
      schacPersonalCharacteristics
      schacContactLocation
      schacLinkageIdentifiers
      schacEntryMetadata
      schacUserEntitlements
      schacExperimentalOC
    ].freeze

    ROLE_SCOPES = {
      faculty: %i[member employee],
      staff:   %i[member employee],
      student: %i[member]
    }.freeze

    # rubocop:disable Naming/MethodName
    module Attributes
      def cn
        user.full_name
      end

      def displayName
        user.full_name
      end

      def eduPersonAffiliation
        user.ldap_roles
            .map { |role| prefixes_for_role(role) }
            .flatten
            .uniq
      end

      def eduPersonPrimaryAffiliation
        user.ldap_roles.min_by { |role| ROLE_SCOPES.keys.index(role) }.to_s
      end

      def eduPersonPrincipalName
        "#{user.username}@#{Tenant.configuration.ldap.organization}"
      end

      def eduPersonPrincipalNamePrior
        'onceki_username'
      end

      def eduPersonScopedAffiliation
        user.ldap_roles.map do |role|
          user.units_by(role).map do |unit|
            prefixes_for_role(role).map do |prefix|
              generate_person_scoped_affiliation(prefix, unit)
            end
          end
        end.flatten
      end

      def givenName
        user.first_name
      end

      def jpegPhoto
        return unless user.avatar.attached?

        Base64.encode64(user.avatar.download)
      end

      def mail
        user.email
      end

      def mobile
        user.mobile_phone
      end

      def preferredLanguage
        user.preferred_language
      end

      # TODO: Gerekli düzenleme yapılmalı
      def schacCountryOfCitizenship
        'Samsun'
      end

      def schacDateOfBirth
        user.date_of_birth.try(:strftime, '%Y%m%d')
      end

      def schacExpiryDate
        '20051231125959Z'
      end

      def schacGender
        user.ldap_gender
      end

      def schacHomeOrganization
        Tenant.configuration.ldap.organization
      end

      def schacPersonalUniqueCode
        'test'
      end

      def schacPersonalUniqueID
        'test'
      end

      def schacPlaceOfBirth
        'test'
      end

      def schacUserStatus
        'test'
      end

      def schacYearOfBirth
        user.date_of_birth.try(:strftime, '%Y')
      end

      def sn
        user.last_name
      end

      def uid
        user.id_number
      end

      def userPassword
        "{BCRYPT}#{user.encrypted_password}"
      end

      def objectclass
        OBJECT_CLASSES
      end

      private

      def prefixes_for_role(role)
        [*ROLE_SCOPES.fetch(role, []), role].map(&:to_s)
      end

      def generate_person_scoped_affiliation(prefix, unit)
        abbreviations = (
          unit.path.pluck(:abbreviation) - Unit.roots.pluck(:abbreviation)
        )

        abbreviations = abbreviations.map { |abbr| abbr.downcase(:turkic) }.reverse.join('.')

        "#{prefix}@_#{abbreviations}.#{Tenant.configuration.ldap.organization}"
      end
    end
    # rubocop:enable Naming/MethodName

    include Attributes

    attr_reader :user

    def initialize(user)
      @user = Ldap::UserDecorator.new(user)
    end

    def dn
      "uid=#{uid}, ou=people, dc=test, dc=omu, dc=edu, dc=tr"
    end

    def to_hash
      attributes.each_with_object({}) do |attribute, hash|
        value = public_send(attribute)
        hash[attribute] = value if value.present?
      end
    end

    alias to_h to_hash
    alias values to_hash

    def create
      LdapEntity.create(user_id: user.id, values: values, dn: dn)
    end

    private

    def attributes
      Attributes.instance_methods
    end
  end
end
