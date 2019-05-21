# frozen_string_literal: true

module Ldap
  class Entity
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
        'test'
      end

      def eduPersonPrincipalNamePrior
        'test'
      end

      def eduPersonScopedAffiliation
        'test'
      end

      def givenName
        identity.try(:first_name)
      end

      def jpegPhoto
        'photo'
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
        'test'
      end

      def schacGender
        case identity.try(:gender)
        when 'male'   then 1
        when 'female' then 2
        when 'other'  then 0
        else               9
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

        # identity&.date_of_birth&.strftime('%Y')
      end

      def sn
        identity.try(:last_name)
      end

      def uid
        'username'
      end

      def userPassword
        "{BCRYPT}#{user.encrypted_password}"
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
    end
    # rubocop:enable Naming/MethodName

    include Attributes

    attr_reader :user

    def initialize(user)
      @user = user
    end

    def to_hash
      attributes.each_with_object({}) do |attribute, hash|
        hash[attribute] = public_send(attribute)
      end
    end

    alias to_h to_hash

    private

    def attributes
      Attributes.instance_methods
    end
  end
end
