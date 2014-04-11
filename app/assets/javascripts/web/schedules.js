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
  var program_table_trs = $("table#april-11 tr").filter(function(index) {
    var hour = parseInt(this.id.split("_")[0]);
    var minute = parseInt(this.id.split("_")[1]);
    var date = new Date();
    var now_hour = date.getHours();
    var now_minute = date.getMinutes();
    return (hour < now_hour || ( hour <= now_hour && minute < now_minute))
  });
  var current_height = 0;
  for (var i = 0; i < program_table_trs.size(); i++) {
    current_height += program_table_trs[i].clientHeight;
  }
  function digitalWatch() {
    var date = new Date();
    var hours = date.getHours();
    var minutes = date.getMinutes();
    current_height += $("#_" + hours + "_" + minutes + "_tr").height();
    if (hours < 10) hours = "0" + hours;
    if (minutes < 10) minutes = "0" + minutes;
    $(".programm__timer-time").html(hours + "<span>" + minutes + "</span>");
    $(".programm__timer").css({height: current_height});
    if (hours > 20) {
      $(".programm__timer").css({display: "none"});
    }
    setTimeout(function() { digitalWatch(); } , 60000);
  }
  digitalWatch();

});
