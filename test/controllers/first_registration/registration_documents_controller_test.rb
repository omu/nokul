# frozen_string_literal: true

require 'test_helper'

module FirstRegistration
  class RegistrationDocumentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @registration_document = registration_documents(:omu_health_report)
      @unit = @registration_document.unit
      @form_params = %w[unit_id document_type_id academic_term_id description]
    end

    test 'should get index' do
      get registration_documents_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_registration_document_link')
    end

    test 'should get new' do
      get new_registration_document_path

      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select ".registration_document_#{param}"
        end
      end
    end

    test 'should create registration_document' do
      assert_difference('RegistrationDocument.count') do
        post registration_documents_path, params: {
          registration_document: {
            unit_id: units(:uzem).id,
            document_type_id: document_types(:ales).id,
            academic_term_id: academic_terms(:spring_2017_2018).id,
            description: 'Lorem ipsum!'
          }
        }
      end

      assert_equal 'create', @controller.action_name

      registration_document = RegistrationDocument.last

      assert_equal units(:uzem).name, registration_document.unit.name
      assert_equal document_types(:ales).name, registration_document.document_type.name
      assert_equal 'Lorem ipsum!', registration_document.description

      assert_redirected_to :registration_documents
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_registration_document_path(@registration_document)

      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select ".registration_document_#{param}"
        end
      end
    end

    test 'should update registration_document' do
      patch registration_document_path(@registration_document), params: {
        registration_document: {
          description: 'halo!'
        }
      }

      @registration_document.reload

      assert_equal 'update', @controller.action_name
      assert_equal 'halo!', @registration_document.description

      assert_redirected_to :registration_documents
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy registration_document' do
      assert_difference('RegistrationDocument.count', -1) do
        delete registration_document_path(registration_documents(:registration_document_to_delete))
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to :registration_documents
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("first_registration.registration_documents#{key}")
    end
  end
end
