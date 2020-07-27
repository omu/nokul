# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class AccountTest < ApplicationSystemTestCase
  setup do
    @user = users(:serhat)
    login_as(@user, scope: :user, run_callbacks: false)
    page.driver.browser.manage.window.resize_to(1024, 768)
    visit(root_path)
    within('.c-sidebar-nav') do
      click_on(t('layouts.shared.sidebar.accounts'))
    end
  end

  test 'check student menu items' do
    roi.find_link(t('patron.accounts.student'), match: :first).click
    assert roi.has_link?(t('layouts.shared.menus.student.course_enrollment'))
    assert roi.has_no_link?(t('layouts.shared.menus.admin.administration'))
  end

  test 'check employee menu items' do
    roi.find_link(t('patron.accounts.employee')).click
    assert roi.has_link?(t('layouts.shared.menus.employee.given_courses'))
    assert roi.has_no_link?(t('layouts.shared.menus.admin.administration'))
  end

  test 'check admin menu items' do
    roi.find_link(t('patron.accounts.admin')).click
    assert roi.has_link?(t('layouts.shared.menus.admin.units'))
    assert roi.has_link?(t('layouts.shared.menus.admin.administration'))
    assert roi.has_link?(t('layouts.shared.menus.admin.users'))
  end

  private

  def roi
    @roi = page.find('.c-sidebar-nav')
  end
end
