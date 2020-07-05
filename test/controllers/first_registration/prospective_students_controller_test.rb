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

    test 'should get new' do
      get new_prospective_student_path
      assert_equal 'new', @controller.action_name
      assert_response :success
    end

    test 'should create prospective student' do
      academic_term = academic_terms(:fall_2018_2019)
      parameters = {
        id_number:                '78784545987',
        first_name:               'Test First Name',
        last_name:                'TEST SURNAME',
        gender:                   'male',
        unit_id:                  units(:bilgisayar_muhendisligi_programi).id,
        academic_term_id:         academic_term.id,
        expiry_date:              academic_term.end_of_term,
        year:                     2018,
        student_entrance_type_id: StudentEntranceType.find_by(name: 'ÖSYS').id
      }

      assert_difference('ProspectiveStudent.count') do
        post prospective_students_path, params: { prospective_student: parameters }
      end

      assert_equal 'create', @controller.action_name

      prospective_student = ProspectiveStudent.last

      parameters.each do |attribute, value|
        assert_equal value, prospective_student.public_send(attribute)
      end

      assert_redirected_to :prospective_students
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_prospective_student_path(@prospective_student)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update prospective_student' do
      prospective_student = ProspectiveStudent.last
      patch prospective_student_path(prospective_student), params: {
        prospective_student: {
          nationality: 'turkish'
        }
      }
      assert_equal 'update', @controller.action_name

      prospective_student.reload
      assert_equal 'turkish', prospective_student.nationality
      assert_redirected_to prospective_student_path(prospective_student)
      assert_equal translate('.update.success'), flash[:notice]
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
      assert(student.permanently_registered)
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
      assert_not(student.permanently_registered)
      assert_redirected_to :prospective_students
      assert_equal translate('.register.success'), flash[:notice]
    end

    test 'should not register prospective_student without e-mail' do
      assert_no_difference('User.count') do
        assert_no_difference('Student.count') do
          get register_prospective_student_path(prospective_students(:hira))
        end
      end

      assert_equal 'register', @controller.action_name
      assert_redirected_to prospective_students(:hira)
      assert_not_empty flash[:alert]
    end

    private

    def translate(key)
      t("first_registration.prospective_students#{key}")
    end
  end
end
