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
