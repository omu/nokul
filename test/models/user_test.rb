# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper
  include ActiveJob::TestHelper

  # relations
  has_many :addresses, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :certifications, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :duties, through: :employees
  has_many :units, through: :employees
  has_many :positions, through: :duties
  has_many :prospective_employees
  has_many :prospective_students
  has_many :administrative_functions, through: :duties
  # relations with patron
  has_many :scope_assignments, class_name: 'Patron::ScopeAssignment', dependent: :destroy
  has_many :query_stores, class_name: 'Patron::QueryStore', through: :scope_assignments
  has_many :role_assignments, class_name: 'Patron::RoleAssignment', dependent: :destroy
  has_many :roles, class_name: 'Patron::Role', through: :role_assignments
  has_many :permissions, class_name: 'Patron::Permission', through: :roles

  # validations: presence
  validates_presence_of :email
  validates_presence_of :id_number
  validates_presence_of :preferred_language

  # validations: uniqueness
  validates_uniqueness_of :email
  validates_uniqueness_of :id_number

  # validations: length
  validates_length_of :email
  validates_length_of :extension_number, maximum: 8
  validates_length_of :id_number, is: 11
  validates_length_of :linkedin, maximum: 50
  validates_length_of :fixed_phone
  validates_length_of :skype, maximum: 50
  validates_length_of :twitter, maximum: 50
  validates_length_of :website, maximum: 50

  # validations: numericality
  validates_numericality_of :id_number
  validates_numericality_of :extension_number

  # callback tests
  after_commit :build_address_information
  after_commit :build_identity_information

  # validations: email
  test 'email addresses validated against RFC' do
    fake = users(:serhat).dup
    [
      'Abc\@def@example.com',
      'Fred\ Bloggs@example.com',
      'Joe.\\Blow@example.com',
      '"Abc@def"@example.com'
    ].each do |email|
      fake.email = email
      assert_not fake.valid?
      assert_not_empty fake.errors[:email]
    end
  end

  # validations: avatar
  test 'a user can upload a valid JPG/JPEG/PNG images as avatar' do
    skip # TODO: https://github.com/rails/rails/issues/33016
    [
      ['valid_jpg_picture.jpg', 'image/jpg'],
      ['valid_jpeg_picture.jpeg', 'image/jpeg'],
      ['valid_png_picture.png', 'image/png']
    ].each do |mime_type|
      assert_difference 'ActiveStorage::Attachment.count' do
        users(:serhat).avatar.attach!(file_fixture(mime_type.first))
        assert users(:serhat).avatar.attached?
      end
    end
  end

  test 'a user can not try media type spoofing' do
    skip # TODO: https://github.com/rails/rails/issues/33016
    [
      ['invalid_sh_file.jpg', 'image/jpg'],
      ['invalid_xml_file.jpg', 'image/jpg'],
      ['invalid_small_picture.jpg', 'image/jpg'],
      ['invalid_big_picture.jpg', 'image/jpg']
    ].each do |mime_type|
      assert_no_difference 'ActiveStorage::Attachment.count' do
        users(:serhat).avatar.attach(file_fixture(mime_type.first))
        assert_not users(:serhat).avatar.attached?
      end
    end
  end

  # custom tests
  test 'user can respond to account method' do
    assert users(:serhat).accounts
  end

  test 'user can respond to title method' do
    assert_equal users(:serhat).title, 'Araştırma Görevlisi'
  end

  %i[employee? student? academic?].each do |method|
    test "user can respond to #{method} method" do
      assert     users(:serhat).public_send(method)
      assert_not users(:mine).public_send(method)
    end
  end

  # job tests
  test 'user enqueues Kps::AddressSaveJob after being created' do
    assert_enqueued_with(job: Kps::AddressSaveJob) do
      password = SecureRandom.hex(20).freeze
      User.create(
        id_number:             '12345678912',
        email:                 'fakeuser@omu.edu.tr',
        password:              password,
        password_confirmation: password
      )
    end
  end

  test 'user runs Kps::IdentitySaveJob after being created' do
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      password = SecureRandom.hex(20).freeze
      User.create(
        id_number:             '98765432198',
        email:                 'anotherfakeuser@omu.edu.tr',
        password:              password,
        password_confirmation: password
      )
    end
  end

  test 'check user activation status' do
    assert users(:john).active_for_authentication? # activated user
    assert_not users(:mine).active_for_authentication? # not activated user
  end

  # patron-roleable tests
  test 'roles? method' do
    assert users(:serhat).roles?(:admin)
    assert_not users(:serhat).roles?(:admin, :foo)
  end

  test 'role? method' do
    assert users(:serhat).role?(:admin)
    assert_not users(:serhat).role?(:foo)
  end

  test 'any_roles? method' do
    assert users(:serhat).any_roles?(:admin, :foo)
    assert_not users(:serhat).any_roles?(:bar, :foo)
  end

  test 'permissions? method' do
    assert users(:serhat).permission?(:course_management)
    assert_not users(:serhat).permission?(:course_management, :foo)
  end

  test 'permission? method' do
    assert users(:serhat).permission?(:course_management)
    assert_not users(:serhat).permission?(:foo)
  end

  test 'any_permissions? method' do
    assert users(:serhat).any_permissions?(:course_management, :foo)
    assert_not users(:serhat).any_permissions?(:bar, :foo)
  end
end
