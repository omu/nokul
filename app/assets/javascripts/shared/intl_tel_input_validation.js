// validate the telephone number on the blur event

var TelInputValidation = function(input_id, error_msg_id, error_messages) {
  var input = document.querySelector(input_id),
    error_msg = document.querySelector(error_msg_id);

  var reset = function () {
    input.classList.remove('is-invalid');
    input.classList.remove('is-valid');
    error_msg.innerHTML = '';
  };

  var iti = window.intlTelInput(input, {
    utilsScript: 'assets/shared/intl_tel_input_utils.js',
    nationalMode: false,
    initialCountry: 'tr',
    preferredCountries: ['tr']
  })

  input.addEventListener('blur', function() {
    reset();
    if (input.value.trim()) {
      if (iti.isValidNumber()) {
        input.classList.add('is-valid');
      } else {
        input.classList.add('is-invalid');
        var error_code = iti.getValidationError();
        error_msg.innerHTML = error_messages[error_code] || error_messages[0]
      }
    }
  });

  input.addEventListener('change', reset);
  input.addEventListener('keyup', reset);
}
