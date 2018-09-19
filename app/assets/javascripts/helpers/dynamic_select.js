/* eslint-env jquery */

'use strict'

var DynamicSelect = function (parameters) {
  function init () {
    $.each(parameters, function (k, parameter) {
      $(parameter['el']).change(function (event) {
        var path = generateSourcePath(parameter)
        var config = {
          label_attribute: parameter['label_attribute'],
          value_attribute: parameter['value_attribute'],
          placeholder: parameter['placeholder'],
          target: parameter['target']
        }
        reset($(parameter['reset_selectors']))
        builder(path, config)
      })
    })
  }

  function builder (path, config) {
    $.getJSON(path, function (response) {
      var options = new OptionsBuilder(
        response, config.placeholder, { 'labelMethod': config.label_attribute, 'valueMethod': config.value_attribute }
      )
      options.setSelectBox($(config.target))
    })
  }

  function generateSourcePath (parameter) {
    var source = parameter['source']
    $.each(parameter['params'], function (key, selector) {
      source = source.replace(`:${key}`, $(selector).val())
    })
    return source
  }

  function reset (elements) {
    elements.html('')
    elements.attr('disabled', true)
  }

  return {
    init: init
  }
}

var OptionsBuilder = function (datas, placeholder, config = {}) {
  function build () {
    var options = []

    if (placeholder) {
      options.push(addPlaceHolder())
    }

    $.each(datas, function (_, data) {
      var option = addOption(data)
      if (option) {
        options.push(option)
      }
    })

    return options
  }

  function addOption (data) {
    var id = data[config.valueMethod || 'id']
    var text = data[config.labelMethod || 'name']

    if (text !== null && text !== '') {
      return `<option value=${id}>${text}</option>`
    }
  }

  function addPlaceHolder () {
    return `<option value="">${placeholder}</option>`
  }

  function setSelectBox (el) {
    var options = build()
    el.html(options.join(' '))
    el.attr('disabled', false)
  }

  return {
    build: build,
    setSelectBox: setSelectBox
  }
}