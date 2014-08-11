// Forms that have '.changes-confirmed' class will have their changes confirmed for any
// unload action that is initiated by anything except a submit tag

$(document).ready(function(){
  if(document.getElementsByClassName('changes-confirmed')){
    var unsaved = false;

    // Another way to bind the event
    $(window).bind('beforeunload', function() {
      if(unsaved){
        return "You have unsaved changes on this page. Do you want to leave this page and discard your changes or stay on this page?";
      }
    });

    // Monitor dynamic inputs
    $(document).on('change', 'form.changes-confirmed :input', function(){ //triggers change in all input fields including text type
      unsaved = true;
    });

    $('form.changes-confirmed :submit').click(function() {
      unsaved = false;
    });
  }
})
