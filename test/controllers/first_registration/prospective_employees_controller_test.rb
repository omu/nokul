# frozen_string_literal: true

require 'test_helper'

module FirstRegistration
  class ProspectiveEmployeesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @prospective_employee = prospective_employees(:hira)
    end

    test 'should get index' do
      get prospective_employees_path
      assert_equal 'index', @controller.action_name
      assert_response :success
    end

    test 'should get new' do
      get new_prospective_employee_path
      assert_equal 'new', @controller.action_name
      assert_response :success
    end

    test 'should create prospective employee' do
      parameters = {
        id_number: '56593662552', # Sample ID number provided by KPS
        first_name: 'Mine',
        last_name: 'URASLI',
        date_of_birth: '1984-11-16'.to_date,
        gender: 'female',
        email: 'mineurasli@gmail.com',
        mobile_phone: '5552111111',
        staff_number: 'A5100',
        unit_id: units(:bilgisayar_muhendisligi).id,
        title_id: titles(:research_assistant).id
      }

      assert_difference('ProspectiveEmployee.count') do
        post prospective_employees_path, params: { prospective_employee: parameters }
      end

      assert_equal 'create', @controller.action_name

      prospective_employee = ProspectiveEmployee.last

      parameters.each do |attribute, value|
        assert_equal value, prospective_employee.send(attribute)
      end

      assert_redirected_to :prospective_employees
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_prospective_employee_path(@prospective_employee)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update prospective employee' do
      patch prospective_employee_path(@prospective_employee), params: {
        prospective_employee: {
          title_id: titles(:computer_operator).id
        }
      }
      assert_equal 'update', @controller.action_name

      @prospective_employee.reload
      assert_equal 'Bilgisayar İşletmeni', @prospective_employee.title_name
      assert_redirected_to :prospective_employees
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy prospective employee' do
      assert_difference('ProspectiveEmployee.count', -1) do
        delete prospective_employee_path(prospective_employees(:prospective_employee_to_delete))
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to :prospective_employees
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("first_registration.prospective_employees#{key}")
    end
  end
end
