# frozen_string_literal: true

module LinkHelper
  LINKS = {
    back: {
      icon: 'arrow-left',
      text: I18n.t('action_group.back'),
      options: {
        class: 'btn btn-secondary btn-sm'
      }
    },
    destroy: {
      icon: 'trash',
      text: I18n.t('action_group.destroy'),
      options: {
        class: 'btn btn-outline-danger btn-sm',
        method: :delete,
        data: { confirm: I18n.t('are_you_sure') }
      }
    },
    edit: {
      icon: 'pencil',
      text: I18n.t('action_group.edit'),
      options: {
        class: 'btn btn-outline-success btn-sm'
      }
    },
    file: {
      icon: 'file-word-o',
      text: I18n.t('action_group.file'),
      options: {
        class: 'btn btn-secondary btn-sm'
      }
    },
    new: {
      icon: 'plus',
      text: I18n.t('action_group.add'),
      options: {
        class: 'btn btn-outline-primary btn-sm',
        id: 'add-button'
      }
    },
    show: {
      icon: 'eye',
      text: I18n.t('action_group.show'),
      options: {
        class: 'btn btn-outline-info btn-sm'
      }
    },
    update: {
      icon: 'pencil-square-o',
      text: I18n.t('action_group.update'),
      options: {
        class: 'btn btn-outline-info btn-sm'
      }
    }
  }.freeze

  # Usage:
  # link_to_#{action}(path)
  # link_to_#{action}(path, options = {})
  # link_to_#{action}(text, path, options = {})
  LINKS.each do |action, configuration|
    define_method("link_to_#{action}") do |*args|
      link_builder(args, configuration)
    end
  end

  BASE_ACTIONS = %i[show edit destroy].freeze

  # Basic Usage:
  # link_to_actions(path)
  # link_to_actions(course, except: :show)
  #
  # Advance Usage:
  # link_to_actions(path,
  #                 scope: :admin,
  #                 except: :show,
  #                 edit: { text: 'Edit Text', options: { class: 'btn btn-danger' } },
  #                 destroy: { options: { class: 'btn btn-danger' } })
  def link_to_actions(path, options = {})
    actions = BASE_ACTIONS - [*options[:except]].map(&:to_sym)
    safe_join(
      create_links_for(path, actions, options),
      ' '
    )
  end

  private

  def create_links_for(path, actions, options = {})
    config = {
      edit: { path_prefix: :edit }
    }

    actions.map do |action|
      send("link_to_#{action}",
           options.dig(action, :text),
           [*config.dig(action, :path_prefix), *options[:scope], *path],
           options.dig(action, :options))
    end
  end

  def link_builder(args, configuration)
    text, path, custom_options = split_args_for_link_to(args)
    options = configuration.fetch(:options, {})
    options = options.merge(custom_options) if custom_options.is_a?(Hash)

    link_to(
      fa_icon(configuration[:icon], text: text || configuration[:text]),
      path,
      options
    )
  end

  def split_args_for_link_to(args)
    number_of_args_check = args.last.is_a?(::Hash) ? 2 : 1
    args.length == number_of_args_check ? [nil, *args] : args
  end
end
