$(document).on('ready page:load', function(){
  var datetimepicker = $('#datetimepicker').datetimepicker({
      inline: true,
      sideBySide: true,
      format: "YYYY-MM-DDThh:mmTZ"
  });

  match = $('div.match-row').first();
  while( match.hasClass('match-row') ) {
    matchDate = new Date( match.find('.match-date').text() );
    console.log(matchDate);

    dateString = matchDate.getMonth()+1 + "월 " + matchDate.getDate() + "일 (";
    dateString += ["월","화","수","목","금","토","일"][matchDate.getDay()] + ")";
    match.find('.match-date-string').html(dateString);

    timeString = sprintf("%02d:%02d",matchDate.getHours(),matchDate.getMinutes());
    match.find('.match-time-string').html(timeString);

    match = match.next();
  }

  $('td .btn').addClass("button-primary");

  updateDateInput = function() {
    console.log(datetimepicker.data().date);
    $('#match-date').val(datetimepicker.data().date);
  };

  if ( $('#match-date').val() ) {
    console.dir(moment($('#match-date').val()));
    $('#datetimepicker').data("DateTimePicker").date($('#match-date').val());
  } else {
    datetimepicker.show(updateDateInput);
  }

  datetimepicker.change(updateDateInput);

  $('#new_match').on('submit', function(e) {
    var date = $('#datetimepicker').data().date;
    $('#match-date').val(date);
  });
});