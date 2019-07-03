# frozen_string_literal: true

require 'test_helper'

module Ldap
  class EntityTest < ActiveSupport::TestCase
    setup do
      @user   = Ldap::UserDecorator.new(users(:serhat))
      @entity = Ldap::Entity.new(users(:serhat))
    end

    test 'cn attribute' do
      assert_equal @entity.cn, @user.full_name
    end

    test 'displayName attribute' do
      assert_equal @entity.displayName, @user.full_name
    end

    test 'eduPersonAffiliation attribute' do
      assert_equal @entity.eduPersonAffiliation, %w[member employee faculty student]
    end

    test 'eduPersonPrimaryAffiliation attribute' do
      assert_equal @entity.eduPersonPrimaryAffiliation, 'faculty'
    end

    test 'eduPersonPrincipalName attribute' do
      assert_equal @entity.eduPersonPrincipalName,
                   "#{@user.username}@#{Tenant.configuration.ldap.organization}"
    end

    test 'eduPersonPrincipalNamePrior attribute' do
      assert_equal @entity.eduPersonPrincipalNamePrior, 'onceki_username'
    end

    test 'eduPersonScopedAffiliation attribute' do
      assert_equal @entity.eduPersonScopedAffiliation, %w[
        member@_.egitim-bilim.omu.edu.tr
        employee@_.egitim-bilim.omu.edu.tr
        faculty@_.egitim-bilim.omu.edu.tr
        member@_.baum.omu.edu.tr
        employee@_.baum.omu.edu.tr
        faculty@_.baum.omu.edu.tr
        member@_.bilgisayar-pr.bilgisayar.muhendislik.omu.edu.tr
        student@_.bilgisayar-pr.bilgisayar.muhendislik.omu.edu.tr
        member@_.mf-mat-pr.matematik-fen.egitim.omu.edu.tr
        student@_.mf-mat-pr.matematik-fen.egitim.omu.edu.tr
      ]
    end

    test 'givenName attribute' do
      assert_equal @entity.givenName, @user.first_name
    end

    test 'jpegPhoto attribute' do
      assert_nil @entity.jpegPhoto, nil
    end

    test 'mail attribute' do
      assert_equal @entity.mail, @user.email
    end

    test 'schacCountryOfCitizenship attribute' do
      assert_equal @entity.schacCountryOfCitizenship, 'se'
    end

    test 'schacDateOfBirth attribute' do
      assert_equal @entity.schacDateOfBirth, @user.date_of_birth.try(:strftime, '%Y%m%d')
    end

    test 'schacExpiryDate attribute' do
      assert_nil @entity.schacExpiryDate
    end

    test 'schacGender attribute' do
      assert_equal @entity.schacGender, '1'
    end

    test 'schacHomeOrganization attribute' do
      assert_equal @entity.schacHomeOrganization, Tenant.configuration.ldap.organization
    end

    test 'schacPersonalUniqueCode attribute' do
      assert_equal @entity.schacPersonalUniqueCode, [
        "urn:schac:personalUniqueCode:tr:employeeID:#{Tenant.configuration.ldap.organization}:A2000",
        "urn:schac:personalUniqueCode:tr:studentID:#{Tenant.configuration.ldap.organization}:12345",
        "urn:schac:personalUniqueCode:tr:studentID:#{Tenant.configuration.ldap.organization}:98765"
      ]
    end

    test 'schacPersonalUniqueID attribute' do
      assert_equal @entity.schacPersonalUniqueID, [
        "urn:schac:personalUniqueID:tr:NIN:#{@user.id_number}"
      ]
    end

    test 'sn attribute' do
      assert_equal @entity.sn, @user.last_name
    end

    test 'uid attribute' do
      assert_equal @entity.uid, @user.id_number
    end

    test 'userPassword attribute' do
      assert_equal @entity.userPassword, "{BCRYPT}#{@user.encrypted_password}"
    end

    test 'objectclass attribute' do
      assert_equal @entity.objectclass, %w[
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
  end
end
