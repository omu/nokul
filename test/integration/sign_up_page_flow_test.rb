# frozen_string_literal: true

require 'test_helper'

class SignUpPageFlowTest < ActionDispatch::IntegrationTest
  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can sign up with correct credentials with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(*resolution)
      visit(new_user_registration_path)
      {
        id_number: '70336212330', # valid test id (see documents to pick a test id)
        email: 'new_user@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      }.each do |key, value|
        fill_in("user[#{key}]", with: value)
      end
      click_button(t('devise.common.register'))
      assert_equal t('devise.registrations.signed_up'), page.find('div', class: 'toast-message').text
    end

    test "can not sign up with missing credentials with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(*resolution)
      visit(new_user_registration_path)
      {
        email: 'new_user@gmail.com'
      }.each do |key, value|
        fill_in("user[#{key}]", with: value)
      end
      click_button(t('devise.common.register'))
      assert_not page.has_content?('Please fill out this field.')
    end
  end
end
