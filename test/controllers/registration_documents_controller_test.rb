# frozen_string_literal: true

require 'test_helper'

class RegistrationDocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:serhat)
    @registration_document = registration_documents(:omu_health_report)
    @unit = @registration_document.unit
  end

  test 'should get index' do
    get unit_registration_documents_path(@unit)
    assert_response :success
    assert_select '#add-button', t('registration_documents.index.new_registration_document_link')
  end

  test 'should get show' do
    get unit_registration_document_path(@unit, @registration_document)
    assert_response :success
  end

  test 'should get new' do
    get new_unit_registration_document_path(@unit)
    assert_response :success
  end

  test 'should create registration_document' do
    assert_difference('@unit.registration_documents.count') do
      post unit_registration_documents_path(@unit), params: {
        registration_document: {
          academic_term_id: academic_terms(:spring_2017_2018).id, document_id: documents(:health_report).id
        }
      }
    end

    registration_document = @unit.registration_documents.last

    assert_equal academic_terms(:spring_2017_2018), registration_document.academic_term
    assert_equal documents(:health_report), registration_document.document

    assert_redirected_to unit_path(@unit)
    assert_equal t('registration_documents.create.success'), flash[:notice]
  end

  test 'should update registration_document' do
    registration_document = @unit.registration_documents.first

    patch unit_registration_document_path(@unit, registration_document), params: {
      registration_document: {
        academic_term_id: academic_terms(:spring_2017_2018).id, document_id: documents(:health_report).id
      }
    }

    registration_document.reload

    assert_equal academic_terms(:spring_2017_2018), registration_document.academic_term
    assert_equal documents(:health_report), registration_document.document

    assert_redirected_to unit_path(@unit)
    assert_equal t('registration_documents.update.success'), flash[:notice]
  end

  test 'should destroy registration_document' do
    assert_difference('@unit.registration_documents.count', -1) do
      delete unit_registration_document_path(@unit, @unit.registration_documents.last)
    end

    assert_redirected_to unit_path(@unit)
    assert_equal t('registration_documents.destroy.success'), flash[:notice]
  end
end
