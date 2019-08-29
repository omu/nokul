// validate the telephone number on the blur event

var TelInputValidation = function (inputId, errorMsgId, errorMessages) { // eslint-disable-line no-unused-vars
  var input = document.querySelector(inputId)
  var errorMsg = document.querySelector(errorMsgId)

  var reset = function () {
    input.classList.remove('is-invalid')
    input.classList.remove('is-valid')
    errorMsg.innerHTML = ''
  }

  var iti = window.intlTelInput(input, {
    utilsScript: 'assets/shared/intl_tel_input_utils.js',
    nationalMode: false,
    initialCountry: 'tr',
    preferredCountries: ['tr']
  })

  input.addEventListener('blur', function () {
    reset()
    if (input.value.trim()) {
      if (iti.isValidNumber()) {
        input.classList.add('is-valid')
      } else {
        input.classList.add('is-invalid')
        var errorCode = iti.getValidationError()
        errorMsg.innerHTML = errorMessages[errorCode] || errorMessages[0]
      }
    }
  })

  input.addEventListener('change', reset)
  input.addEventListener('keyup', reset)
}
