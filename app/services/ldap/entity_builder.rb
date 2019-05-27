# frozen_string_literal: true

module Ldap
  class EntityBuilder
    # rubocop:disable Naming/MethodName
    module Attributes
      def cn
        identity.try(:full_name)
      end

      def displayName
        identity.try(:full_name)
      end

      def eduPersonAffiliation
        affiliations.select { |_, value| value[:status] }
                    .map    { |_, value| value[:scope] << value[:key] }
                    .flatten
                    .sort
                    .uniq
      end

      def eduPersonPrimaryAffiliation
        primary = affiliations.select { |_, value| value[:status] }
                              .max_by { |_, value| value[:priority] }

        (primary.try(:last) || {})[:key]
      end

      def eduPersonPrincipalName
        "#{username}@#{Tenant.configuration.ldap.organization}"
      end

      def eduPersonPrincipalNamePrior
        'onceki_username'
      end

      def eduPersonScopedAffiliation
        scoped_affiliations.select { |_, value| value[:status] }.map do |_, value|
          value[:prefixes].map do |prefix|
            value[:units].map { |unit| generate_person_scoped_affiliation(prefix, unit) }
          end
        end.flatten
      end

      def givenName
        identity.try(:first_name)
      end

      def jpegPhoto
        return unless user.avatar.attached?

        # "data:#{user.avatar.content_type};base64" +
        Base64.encode64(user.avatar.download)
      end

      def mail
        user.email
      end

      def mobile
        user.phone_number
      end

      def preferredLanguage
        user.preferred_language
      end

      def schacCountryOfCitizenship
        'test'
      end

      def schacDateOfBirth
        identity.try(:date_of_birth).try(:strftime, '%Y%m%d')
      end

      def schacExpiryDate
        '20051231125959Z'
      end

      def schacGender
        case identity.try(:gender)
        when 'male'   then '1'
        when 'female' then '2'
        when 'other'  then '0'
        else               '9'
        end
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
        identity.try(:date_of_birth).try(:strftime, '%Y')
      end

      def sn
        identity.try(:last_name)
      end

      def uid
        user.id_number
      end

      def userPassword
        "{BCRYPT}#{user.encrypted_password}"
      end

      def objectclass
        %w[
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
        ]
      end

      private

      def affiliations
        @affiliations ||= {
          academic: {
            status: user.employee? && user.academic?,
            priority: 5,
            key: 'faculty',
            scope: %w[member employee]
          },
          staff: {
            status: user.employee? && !user.academic?,
            priority: 4,
            key: 'staff',
            scope: %w[member employee]
          },
          student: {
            status: user.student?,
            priority: 3,
            key: 'student',
            scope: %w[member]
          },
          affiliate: {
            status: !user.employee? && !user.student?,
            priority: 2,
            key: 'affiliate',
            scope: []
          }
        }
      end

      def identity
        @identity ||= user.identities.user_identity
      end

      def username
        user.id_number
      end

      def scoped_affiliations
        @scoped_affiliations ||= {
          academic: {
            status: user.employee? && user.academic?,
            prefixes: %w[member employee faculty],
            units: user.duties.active.map(&:unit)
          },
          staff: {
            status: user.employee? && !user.academic?,
            prefixes: %w[member employee staff],
            units: user.duties.active.map(&:unit)
          },
          student: {
            status: user.student?,
            prefixes: %w[member student],
            units: user.students.map(&:unit)
          }
        }
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
      @user = user
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
