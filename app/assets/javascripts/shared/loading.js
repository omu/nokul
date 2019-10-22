/* eslint-env jquery */

document.body.addEventListener('ajax:beforeSend', function (event) {
  $('#loading').show()
})

document.body.addEventListener('ajax:error', function (event) {
  window.alert('error')
})

document.body.addEventListener('ajax:complete', function (event) {
  $('#loading').hide()
})
