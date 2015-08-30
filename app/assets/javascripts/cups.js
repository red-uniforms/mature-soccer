$(document).on("ready page:load", function() {
  loc = window.location.pathname.split('/').pop();
  console.log(loc);
  if ( loc.length ) {
    $('a.focus').removeClass('focus');
    $('a[data-value="'+loc+'"]').addClass('focus');
  }
});