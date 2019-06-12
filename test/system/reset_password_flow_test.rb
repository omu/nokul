# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class ResetPasswordFlowTest < ApplicationSystemTestCase
  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can login with correct credentials with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(resolution[0], resolution[1])
      visit(recover_path)
      assert find_button(t('account.passwords.new.reset_password'), visible: true).visible?
      assert find_link(t('account.passwords.new.login'), visible: true).visible?
      fill_in('user[email]', with: users(:serhat).email)
      click_button(t('account.passwords.new.reset_password'))
      assert_equal t('devise.passwords.send_paranoid_instructions'), page.find('div', class: 'toast-message').text
    end
  end
end
