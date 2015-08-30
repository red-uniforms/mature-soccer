$(document).on("ready page:load", function() {
  loc = window.location.pathname.split('/').pop();
  $('a[data-value="'+loc+'"]').addClass('focus');
});