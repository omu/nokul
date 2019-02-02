# frozen_string_literal: true

require 'test_helper'

module FirstRegistration
  class ProspectiveStudentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @prospective_student = prospective_students(:jane)
    end

    test 'should get index' do
      get prospective_students_path
      assert_equal 'index', @controller.action_name
      assert_response :success
    end

    test 'should get show' do
      get prospective_student_path(@prospective_student)

      assert_equal 'show', @controller.action_name
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

      assert_equal 'register', @controller.action_name
      assert_equal @prospective_student.email, user.email
      assert_equal user, student.user
      assert_equal true, student.permanently_registered
      assert_redirected_to :prospective_students
      assert_equal translate('.register.success'), flash[:notice]
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

      assert_equal 'register', @controller.action_name
      assert_equal john.email, user.email
      assert_equal user, student.user
      assert_equal false, student.permanently_registered
      assert_redirected_to :prospective_students
      assert_equal translate('.register.success'), flash[:notice]
    end

    test 'should not register prospective_student without e-mail' do
      assert_no_difference('User.count') do
        assert_no_difference('Student.count') do
          get register_prospective_student_path(prospective_students(:serhat))
        end
      end

      assert_equal 'register', @controller.action_name
      assert_redirected_to :prospective_students
      assert_equal translate('.register.warning'), flash[:alert]
    end

    private

    def translate(key)
      t("first_registration.prospective_students#{key}")
    end
  end
end
