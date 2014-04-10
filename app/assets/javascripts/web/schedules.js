function display_hide(blockId) {
  if ($(blockId).css('display') == 'none') {
    $(blockId).animate({height: 'show'}, 500);
  } else {
    $(blockId).animate({height: 'hide'}, 500);
  }
}

function check_my_program_slots(slots) {
  $("#my_programm").on('change', function() {
    if ($(this).is(':checked')) {
      $(".programm__schedule__lectures__lecture").addClass('disable');
      $.each(slots, function(index, value) {
        $("#lecture-" + value).addClass('enable');
      });
    } else {
      $(".programm__schedule__lectures__lecture").removeClass('disable');
      $.each(slots, function(index, value) {
        $("#lecture-" + value).removeClass('enable');
      });
    }
  });
}
$(document).ready(function() {
  function digitalWatch() {
    var date = new Date();
    var hours = date.getHours();
    var minutes = date.getMinutes();
    if (hours < 10) hours = "0" + hours;
    if (minutes < 10) minutes = "0" + minutes;
    $(".programm__timer-time").html(hours + "<span>" + minutes + "</span>");
    setTimeout(function() { digitalWatch(); } , 60000);
  }
  digitalWatch();
});
