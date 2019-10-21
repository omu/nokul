/* eslint-env jquery */

'use strict'

var DynamicSelect = function (parameters) { // eslint-disable-line no-unused-vars
  var Store = {}

  function init () {
    $.each(parameters, function (k, parameter) {
      $(parameter.el).change(function (event, value = undefined) {
        reset($(parameter.reset_selectors))
        builder(
          generateSourcePath(parameter),
          {
            value: value,
            label_attribute: parameter.label_attribute,
            value_attribute: parameter.value_attribute,
            targets: parameter.targets || [parameter.target],
            placeholder: parameter.placeholder
          }
        )
      })
      if ('after_initialize' in parameter) parameter.after_initialize()
    })
  }

  function builder (path, config) {
    $.getJSON(path, function (response) {
      configureForTargets(config)

      $.each(config.targets, function (el, configuration) {
        if (typeof (configuration) !== 'object') configuration = {}

        var builder = new OptionsBuilder(
          response,
          {
            placeholder: configuration.placeholder || config.placeholder,
            labelMethod: configuration.label_attribute || config.label_attribute,
            valueMethod: configuration.value_attribute || config.value_attribute
          }
        )

        Store[el] = builder.build()
        builder.setSelectBox(el, config.value)
      })
    })
  }

  function generateSourcePath (parameter) {
    var source = parameter.source
    $.each(parameter.params, function (key, selector) {
      source = source.replace(`:${key}`, $(selector).val())
    })
    return source
  }

  function reset (elements) {
    elements.html('')
    elements.attr('disabled', true)
  }

  function getResultForTargetElement (targetElementSelector) {
    return Store[targetElementSelector]
  }

  function configureForTargets (config) {
    if (Array.isArray(config.targets)) {
      var targets = {}

      $.each(config.targets, function (_, element) {
        targets[element] = {}
      })

      config.targets = targets
    }
  }

  return {
    init: init,
    getResultForTargetElement: getResultForTargetElement
  }
}

var OptionsBuilder = function (datas, config = {}) {
  var options = []

  function build () {
    if (options.length > 0) return options
    if (config.placeholder) options.push(`<option value="">${config.placeholder}</option>`)

    datas.forEach(function (data) { addOption(data) })

    return options
  }

  function addOption (data) {
    var id = data[config.valueMethod || 'id']
    var text = data[config.labelMethod || 'name']

    if (text !== null && text !== '') options.push(`<option value=${id}>${text}</option>`)
  }

  function setSelectBox (el, value = undefined) {
    build()
    $(el).html(options.join(' '))
    $(el).attr('disabled', false)
    if (value !== undefined) el.val(value)
  }

  return {
    build: build,
    setSelectBox: setSelectBox
  }
}
