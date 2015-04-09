function display_hide(blockId) {
  if ($(blockId).css('display') == 'none') {
    $(blockId).animate({height: 'show'}, 500);
  } else {
    $(blockId).animate({height: 'hide'}, 500);
  }
}

function check_my_program_slots() {
  $("#my_programm").on('change', function() {
    self = this;
    $.get(Routes.my_programm_api_events_path({format: 'json'}), function(res) {
      var slots = res.events.map(function(e) { return e.voteable_id });
      if ($(self).is(':checked')) {
        $('.schedule__filter').prop('checked', false).change();
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
    })
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

$(function() {
  setTimeout(changeCurrentTimeLine, 1000);

  var $timeline = $('.current_time_line');
  if($timeline) {
    var current_time = parseInt($timeline.closest('tr').data('time'));
    $('.programm__schedule__lectures__lecture').each(function(index, el) {
      var time_to = $(el).data('time-to');
      // 600s = 10min
      if(current_time > time_to && current_time - time_to > 600) {
        $(el).addClass('passed');
      }
    });
  }
});

function showPassedClick(self) {
  $(self).closest('tbody').toggleClass('force_show_passed');
  changeCurrentTimeLine();
}

var changeCurrentTimeLine = function() {
  var $timeline = $('.current_time_line');
  if(!$timeline.length) return;
  var current_time = parseInt($timeline.closest('tr').data('time'));
  var $prev, next_time, prev_time, offset_percent;
  var top = 0;

  $('.programm__schedule tr').each(function(index, el) {
    var time = $(el).data('time');
    if(time > current_time && !$prev) {
      $prev = $(el).prev();
    }
  });

  if($prev) {
    prev_time = $prev.data('time');
    next_time = $prev.next().data('time');

    offset_percent = 100 - (next_time - current_time) / ((next_time - prev_time) / 100);
    top += $prev.position().top;
    top += $prev.height() / 100 * offset_percent;
    top -= $timeline.height();
    $timeline.css('top', top + 'px');
  }
}
