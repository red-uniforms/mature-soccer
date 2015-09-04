$(document).on('ready page:load', function(){
  datetimepicker = $('#datetimepicker').datetimepicker({
      inline: true,
      sideBySide: true,
      format: "YYYY-MM-DDThh:mmTZD"
  });

  $('td .btn').addClass("button-primary");

  updateDateInput = function() {
    console.log(datetimepicker.data().date);
    $('#match-date').val(datetimepicker.data().date);
  };
  
  datetimepicker.show(updateDateInput);

  datetimepicker.change( updateDateInput );

  $('#new_match').on('submit', function(e) {
    var date = datetimepicker.data().date;
    $('#match-date').val(date);
  });
});