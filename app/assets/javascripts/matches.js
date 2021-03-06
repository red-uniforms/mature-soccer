$(document).on('ready page:load', function(){
  var datetimepicker = $('#datetimepicker').datetimepicker({
      inline: true,
      sideBySide: true,
      format: "YYYY-MM-DDTHH:mmTZ A"
  });

  matchClock = $('#match-clock span').first();
  startedAt = new moment( matchClock.attr('value'), "YYYY-MM-DD HH:mm:ss Z" );

  updateClock = function() {
    if( $.inArray(matchClock.attr('status'),["1","2","3","4"]) != -1 ) {
      now = new moment();
      passedTime = now.subtract(startedAt).minute();

      $("#passed-time").text(passedTime);
      // console.log(passedTime);

      window.setTimeout(updateClock, 1000);
    } else {
      $("#passed-time").text('');
    }
  }
  updateClock();

  $('form.new_event').on('submit', function(e) {
    $(this).find('#event-time').val($("#passed-time").text());
    $(this).find('#event-when').val(matchClock.text());
  });

  match = $('div.match-row').first();
  while( match.hasClass('match-row') ) {
    matchDate = new moment( match.find('.match-date').text(), "YYYY-MM-DD HH:mm:ss Z" );

    dateString = matchDate.month()+1 + "월 " + matchDate.date() + "일 (";
    dateString += ["일","월","화","수","목","금","토"][matchDate.day()] + ")";
    match.find('.match-date-string').html(dateString);

    // timeString = sprintf("%02d:%02d",matchDate.hour(),matchDate.minute());
    timeString = matchDate.hour() + "시";

    if( matchDate.minute() < 10 ) {
      timeString += "0" + matchDate.minute() + "분";
    } else {
      timeString += matchDate.minute() + "분";
    }

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

  $('.add-player').on('click',function(e) {
    e.preventDefault();
    var btn = $(this).find('input');
    btn.val("검인 중");

    $.ajax({
      type: 'POST',
      url : $(this).attr('href'),
      processData: false,
      contentType: false
    }).done(function() {
      btn.addClass('button-primary');
      btn.val("완료");
    }).fail(function() {
      btn.addClass('danger');
      btn.val("실패");
    });
  });

});