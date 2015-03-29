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

function lectureClick(id, _this) {
  var myProgrammSelected = $("#my_programm").prop('checked');
  var id = $(_this).data('id');
  var state = $(_this).data('state');
  if(myProgrammSelected) {
    if($(_this).hasClass('disable') && !$(_this).hasClass('enable')) {
      $.ajax({
        url: Routes.api_lecture_lecture_votings_path(id),
        type: "POST",
        dataType: "json",
        success: function() {
          $(_this).removeClass("disable");
          $(_this).addClass("enable");
        }
      })
    } else {
      $.ajax({
        url: Routes.api_lecture_lecture_votings_path(id),
        type: "DELETE",
        dataType: "json",
        success: function() {
          $(_this).addClass("disable");
          $(_this).removeClass("enable");
        }
       })
    }
  } else {
    var url;
    if(state == 'in_schedule') {
      url = Routes.lectures_path({lecture_id: id});
    }
    if(state == 'voted') {
      url = Routes.user_lectures_path({lecture_id: id});
    }
    if(url) window.location.href = url;
  }
}
