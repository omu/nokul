# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class SignUpPageFlowTest < ApplicationSystemTestCase
  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can sign up with a valid identification number under a #{resolution} screen" do
      skip 'this block on CircleCI since it makes requests to Xokul' if ENV['CI']
      page.driver.browser.manage.window.resize_to(*resolution)
      visit(register_path)
      {
        id_number: '70336212330', email: 'new_user@gmail.com',
        password: RANDOM_PASSWORD, password_confirmation: RANDOM_PASSWORD
      }.each do |key, value|
        fill_in("user[#{key}]", with: value)
      end
      click_button(t('account.registrations.new.register'))
      assert_equal t('devise.registrations.user.signed_up'), page.find('div', class: 'toast-message').text
    end

    test "can not sign up with missing credentials with a #{resolution} screen" do
      skip 'this block on CircleCI since it makes requests to Xokul' if ENV['CI']
      page.driver.browser.manage.window.resize_to(*resolution)
      visit(register_path)
      {
        email: 'new_user@gmail.com'
      }.each do |key, value|
        fill_in("user[#{key}]", with: value)
      end
      click_button(t('account.registrations.new.register'))
      assert_not page.has_content?('Please fill out this field.')
    end
  end
end
