$(document).on("ready page:load", function() {
  loc = window.location.pathname.split('/').pop();

  if ( loc != "enccer" ) {
    $('a.focus').removeClass('focus');
    $('a[data-value="'+loc+'"]').addClass('focus');
  }
});