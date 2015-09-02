$(document).on('ready page:load', function(){
  datetimepicker = $('#datetimepicker').datetimepicker({
      inline: true,
      sideBySide: true
  });
  $('#new-match').on('submit', function() {
    var date = datetimepicker.data().date;
    $('#match-date').val(date);
  });
});