# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule
  include ActiveJob::TestHelper

  # relations
  has_many :addresses
  has_many :identities
  has_many :employees
  has_many :students
  has_many :duties
  has_many :units
  has_many :positions
  has_many :administrative_functions
  has_many :certifications
  has_many :articles
  has_many :projects

  # validations: presence
  validates_presence_of :email
  validates_presence_of :id_number
  validates_presence_of :preferred_language

  # validations: uniqueness
  validates_uniqueness_of :email
  validates_uniqueness_of :id_number

  # validations: length
  validates_length_of :email
  validates_length_of :id_number, is: 11

  # validations: numericality
  validates_numericality_of :id_number

  # validations: email
  test 'email addresses validated against RFC' do
    fake = users(:serhat).dup
    [
      'Abc\@def@example.com',
      'Fred\ Bloggs@example.com',
      'Joe.\\Blow@example.com',
      '"Abc@def"@example.com',
      '"Fred Bloggs"@example.com',
      'customer/department=shipping@example.com',
      '$A12345@example.com',
      '!def!xyz%abc@example.com',
      '_somename@example.com'
    ].each do |email|
      fake.email = email
      assert_not fake.valid?
      assert_not_empty fake.errors[:id_number]
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

  # callback tests
  has_commit_callback :build_address_information, :after
  has_commit_callback :build_identity_information, :after

  # job tests
  test 'user enqueues Kps::AddressSaveJob after being created' do
    assert_enqueued_with(job: Kps::AddressSaveJob) do
      User.create(
        id_number: '12345678912',
        email: 'fakeuser@fakemail.com',
        password: '1234567',
        password_confirmation: '1234567'
      )
    end
  end

  test 'user runs Kps::IdentitySaveJob after being created' do
    assert_enqueued_with(job: Kps::IdentitySaveJob) do
      User.create(
        id_number: '98765432198',
        email: 'anotherfakeuser@fakemail.com',
        password: '1234567',
        password_confirmation: '1234567'
      )
    end
  end
end
