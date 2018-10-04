# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:john)
    @prospective_student = prospective_students(:jane)
  end

  test 'should get index' do
    get prospective_students_path
    assert_response :success
  end

  test 'should get show' do
    get prospective_student_path(@prospective_student)
    assert_response :success
  end

  test 'should register prospective_student' do
    skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
    assert_difference('User.count') do
      assert_difference('Student.count') do
        get register_prospective_student_path(@prospective_student.id)
      end
    end

    user = User.last
    student = Student.last

    assert_equal @prospective_student.email, user.email
    assert_equal user, student.user
    assert_equal true, student.permanently_registered
    assert_redirected_to prospective_students_path
    assert_equal t('student_management.prospective_students.register.success'), flash[:notice]
  end

  test 'should temporarily register prospective_student' do
    skip 'this block on CircleCI since it needs IP permissions to run.' if ENV['CI']
    john = prospective_students(:john)
    john.update(military_status: true)

    assert_difference('User.count') do
      assert_difference('Student.count') do
        get register_prospective_student_path(john)
      end
    end

    user = User.last
    student = Student.last

    assert_equal john.email, user.email
    assert_equal user, student.user
    assert_equal false, student.permanently_registered
    assert_redirected_to prospective_students_path
    assert_equal t('student_management.prospective_students.register.success'), flash[:notice]
  end

  test 'should not register prospective_student without e-mail' do
    assert_no_difference('User.count') do
      assert_no_difference('Student.count') do
        get register_prospective_student_path(prospective_students(:serhat))
      end
    end

    assert_redirected_to prospective_students_path
    assert_equal t('student_management.prospective_students.register.warning'), flash[:alert]
  end
end
