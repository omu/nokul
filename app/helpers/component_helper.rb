# frozen_string_literal: true

module ComponentHelper
  STATUSES = {
    success:      'success',
    failed:       'danger',
    pending:      'warning',
    synchronized: 'success'
  }.freeze

  def list_group_tag(items, **options)
    return items unless items.is_a?(Array)

    tag.ul(class: options.fetch(:ul_class, 'list-group')) do
      safe_join(
        items.map { |item| tag.li(item, class: options.fetch(:li_class, 'list-group-item')) }
      )
    end
  end

  def klass_for_status(status)
    return 'secondary' if status.nil?

    STATUSES.fetch(status.to_sym, 'secondary')
  end

  def content_loader_panel_tag(url, header: nil, refresh: {}, &block)
    render 'layouts/components/content_loader_panel',
           url:     url,
           header:  header,
           content: (block_given? ? capture(&block) : nil),
           refresh: OpenStruct.new(
             auto:     refresh.fetch(:auto, false),
             interval: refresh.fetch(:interval, 10_000)
           )
  end

  def content_loader_tag(url)
    render 'layouts/components/content_loader_basic', url: url
  end

  def loading_tag(text = t('loading'), show: false)
    tag.div(class: 'loading', id: 'loading', style: ('display: none;' unless show)) do
      tag.div(class: 'loading-content') do
        safe_join [
          tag.div(tag.span(text, class: 'sr-only'), class: 'spinner-border text-success spinner-large', role: 'status'),
          tag.h4(text, class: 'text-dark')
        ]
      end
    end
  end
end
