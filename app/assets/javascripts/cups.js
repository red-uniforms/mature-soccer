$(document).on("ready page:load", function() {
  list = window.location.pathname.split('/');

  if( list.length == 4 ) {
    loc = list.pop();
    $('a.focus').removeClass('focus');
    $('a[data-value="'+loc+'"]').addClass('focus');
  }
});