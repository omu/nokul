# frozen_string_literal: true

require 'test_helper'

class TableBuilderHelperTest < ActionView::TestCase
  include FontAwesome::Rails::IconHelper
  include LinkHelper

  test 'table method' do
    courses = Course.limit(2)
    html = []
    html << '<table class="table table-responsive-sm table-striped table-hover">'
    html << '<thead class="thead-dark"><th>Name</th><th>İşlemler</th></thead>'
    html << '<tbody>'
    courses.each do |course|
      html << "<tr><td>#{course.name}</td><td>#{link_to_show(course)}</td></tr>"
    end
    html << '</tbody></table>'

    table = table(
      schema: {
        name: :string
      },
      actions: ->(obj) { link_to_show(obj) },
      collection: courses
    )
    assert_equal table, html.join
  end
end
