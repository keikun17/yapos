//= require confirm_changes

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(document).ready(function(){

  // You will need to require 'jquery-ui' for this to work
  window.Rails4ClientSideValidations.callbacks.element.fail = function(element, message, callback) {
    callback();
    if (element.data('valid') !== false) {
      element.parent().find('.message').hide().show('slide', {direction: "left", easing: "easeOutBounce"}, 500);
    }
  }
  window.Rails4ClientSideValidations.callbacks.element.pass = function(element, callback) {
    // Take note how we're passing the callback to the hide()
    // method so it is run after the animation is complete.
    element.parent().find('.message').hide('slide', {direction: "left"}, 500, callback);
  }

})


