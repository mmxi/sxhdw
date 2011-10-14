clientSideValidations.validators.local["email_format"] = function (element, options) {  
  if(!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {  
    return options.message;  
  }  
}

clientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'] = {
  add: function (element, settings, message) {
    if (element.data('valid') !== false) {
      element.after('<span class="validation_message">' + message + '</span>')
    } else {
      element.parent().find('span.validation_message').text(message)
    }
   },
  remove: function (element, settings) {
    wrapper = element.closest('div');
    var errorElement = wrapper.find('span.validation_message');
      errorElement.remove();
  }
}