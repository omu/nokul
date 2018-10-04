# frozen_string_literal: true

require 'test_helper'

class ResetPasswordFlowTest < ActionDispatch::IntegrationTest
  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can login with correct credentials with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(resolution[0], resolution[1])
      visit(new_user_password_path)
      assert find_button(t('devise.passwords.new.send_instructions'), visible: true).visible?
      assert find_link(t('devise.common.login'), visible: true).visible?
      assert find_link(t('devise.common.register'), visible: true).visible?
      fill_in('user[email]', with: users(:serhat).email)
      click_button(t('devise.passwords.new.send_instructions'))
      assert_equal t('devise.passwords.send_instructions'), page.find('div', class: 'toast-message').text
    end
  end
end
