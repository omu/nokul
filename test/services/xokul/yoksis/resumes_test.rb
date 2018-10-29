# frozen_string_literal: true

require 'test_helper'

class ResumesTest < ActiveSupport::TestCase
  setup do
    @id_numbers = YAML.safe_load(
      Sensitive.read(
        Rails.root.join('test', 'fixtures', 'files', 'xokul_id_numbers.yml')
      )
    ).deep_symbolize_keys
  end

  test 'trying to get author informations' do
    assert Xokul::Yoksis::Resumes.authors(
      id_number: @id_numbers[:authors],
      author_id: 252_882
    )

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::Resumes.authors id_number: 11_111_111_111, author_id: -1
      Xokul::Yoksis::Resumes.authors(
        id_number: 'id number as string', author_id: 'author id as string'
      )
    end
  end

  %i[
    academic_duties
    academic_links
    administrative_duties
    articles
    artistic_activities
    awards
    books
    certifications
    designs
    editorships
    education_informations
    fields
    foreign_languages
    lectures
    memberships
    other_experiences
    papers
    patents
    projects
    refereeing
    thesis_advisors
  ].each do |method|
    test "trying to get staff's #{method}" do
      assert Xokul::Yoksis::Resumes.send(
        method,
        id_number: @id_numbers[method]
      )

      assert_raises Net::HTTPError, Net::HTTPFatalError do
        Xokul::Yoksis::Resumes.send method, id_number: 11_111_111_111
        Xokul::Yoksis::Resumes.send method, id_number: 'id number as string'
      end
    end
  end

  %i[
    citations
    incentive_applications
    incentive_activity_declarations
  ].each do |method|
    test "trying to get staff's #{method}" do
      assert Xokul::Yoksis::Resumes.send(
        method,
        id_number: @id_numbers[method],
        year: 2017
      )

      assert_raises Net::HTTPError, Net::HTTPFatalError do
        Xokul::Yoksis::Resumes.send method, id_number: 11_111_111_111, year: -1
        Xokul::Yoksis::Resumes.send method, id_number: 'id as string', year: -1
      end
    end
  end
end
