# frozen_string_literal: true

module TableBuilderHelper
  TableOption = Struct.new(:schema, :actions, :collection, :i18n, :i18n_scope, keyword_init: true) do
    def headers
      schema.keys
    end

    def link_visible?
      actions.present?
    end

    def transform_headers
      if i18n
        headers.map { |header| I18n.t(".#{header}", scope: i18n_scope) }
      else
        headers.map { |header| header.to_s.humanize }
      end
    end

    def table_html_class
      'table table-responsive-sm table-striped table-hover'
    end
  end

  # Table Builder:
  #
  # @example
  # table(
  #  schema: {
  #    name: :string,
  #    unit: ->(obj){ obj.unit.try(:name) },
  #    status: :enum
  #  },
  #  actions: ->(obj){ link_to_actions(@unit, obj)},
  #  collection: @courses
  # )
  def table(config = {})
    config[:i18n_scope] = @virtual_path.split('/')
    opts = TableOption.new(config)
    tag.table class: opts.table_html_class do
      create_thead(opts) + create_tbody(opts)
    end
  end

  private

  def create_thead(opts)
    elements = opts.transform_headers.map { |header| th(header) }
    elements << th(t('actions')) if opts.link_visible?
    tag.thead safe_join(elements), class: 'thead-dark'
  end

  def create_tbody(opts)
    elements = opts.collection.map do |object|
      tag.tr do
        create_tr_content(object, opts.schema, opts.actions)
      end
    end
    tag.tbody safe_join(elements)
  end

  def create_tr_content(object, schema, actions)
    elements = schema.map do |key, type|
      content = case type
                when :string then object[key.to_sym]
                when :enum then enum_t(object, key)
                when Proc then type.call(object)
                end
      td(content)
    end
    elements << create_action_links(object, actions)
    safe_join(elements)
  end

  def create_action_links(object, actions)
    return '' unless actions.is_a?(Proc)
    td(actions.call(object))
  end

  def th(content)
    tag.th content
  end

  def td(content)
    tag.td content
  end
end
