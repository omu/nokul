# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class AccountSettingsFlowTest < ApplicationSystemTestCase
  setup do
    @user = users(:serhat)
    @password = SecureRandom.hex(20).freeze
    login_as(@user, scope: :user, run_callbacks: false)
  end

  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can update account password with a valid password under a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(*resolution)
      visit(account_path)
      {
        password: @password,
        password_confirmation: @password,
        current_password: 'd61c16acabedeab84f1ad062d7ad948ef3'
      }.each do |key, value|
        fill_in("user[#{key}]", with: value)
      end
      click_button(t('helpers.submit.user.update'))
      assert_equal t('devise.registrations.user.updated'), page.find('div', class: 'toast-message').text
    end

    test "can not update account password with a missing password under a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(*resolution)
      visit(account_path)
      {
        password: @password,
        password_confirmation: @password
      }.each do |key, value|
        fill_in("user[#{key}]", with: value)
      end
      click_button(t('helpers.submit.user.update'))
      assert_not page.has_content?('Please fill out this field.')
    end
  end
end
