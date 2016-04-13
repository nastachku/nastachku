/*
 * © Mihail Firsov
 * mihailfirsov.ru
 * dev.firsov@gmail.com
 */

var mobileBreakpoint = 900; // 604
var midScreenBreakpoint = 1440; // 964

function hallCount() {
  return (!_.isUndefined(window.gon) && window.gon.hall_count);
}

function hallIdArray() {
  if (_.isUndefined(hallCount())) {
    return [];
  } else {
    return _.range(1, hallCount()+1);
  }
}

function setNextAndPrevButtons(page, enableAll, disablePrev){
  var $next = $('.programm__next'), $prev=$('.programm__prev');
  $next.attr('data-page', page);
  $prev.attr('data-page', page);
  if (enableAll) {
    $prev.removeClass('disable').attr('data-page', page);
    $next.removeClass('disable').attr('data-page', page);
  } else {
    if (disablePrev) {
      $prev.addClass('disable').attr('data-page', page);
      $next.removeClass('disable').attr('data-page', page);
    } else {
      $next.addClass('disable').attr('data-page', page);
      $prev.removeClass('disable').attr('data-page', page);
    }
  }
}

function chunkArray (array, size) {
  return array.reduce(function (res, item, index) {
    if (index % size === 0) { res.push([]); }
    res[res.length-1].push(item);
    return res;
  }, []);
}

function hallPages () {
  var halfHallCount = Math.ceil(hallCount() / 2);
  return chunkArray(hallIdArray(), halfHallCount);
}

function showAdapticTable() {
  changeCurrentTimeLine();
  var table_class = $("dd.selected table").attr('class');
  if (table_class) {
    var page = Number(table_class.split('page-')[1]);
    var setPageOne = function() {
      page = 1;
      var $table = $("dd.selected table");
      $table.removeClass();
      $table.addClass("page-1");
      setNextAndPrevButtons(page, false, (page == 1));
    };
    if (isNaN(page)) {
      setPageOne();
    }
    hideAllTd();
    if (check_width(mobileBreakpoint)) {
      setNextAndPrevButtons(page, (page != 1 && page != hallCount()), (page == 1));
      showTdOfTable([page]);
    } else if (check_width(midScreenBreakpoint)) {
      if(page > 2) {
        setPageOne();
      }
      var halfHallCount = Math.ceil(hallCount() / 2);
      if(page == 1) {
        var firstPageColumn = hallPages()[0];
        showTdOfTable(firstPageColumn);
      } else if (page == 2) {
        var secondPageColumn = hallPages()[1];
        showTdOfTable(secondPageColumn);
      }
    } else {
      setPageOne();
      showTdOfTable(hallIdArray());
    }
  }
}
jQuery(document).ready(function ($) {
  var $layout=$('#layout'), $overlay=$('#overlay'), $popups=$('.popup');
  $('body').on('click', '.open_this', function() {
    $(this).toggleClass('open');
  });
  $('body').on('click', '.programm__filter__checkboxs-title', function() {
    $(this).toggleClass('active');
  });
  $(window).resize(function(){
    showAdapticTable();
  });
  showAdapticTable();
  $(window).on("load resize", function (){
    if (check_width(mobileBreakpoint)) {
      var options = {
        pagingNav: false,
        scrollbar: false,
        directionNavAutoHide: false,
        itemsPerMove: 1,
        loopItems: true,
        directionNav: true,
        autoplay: false,
        autoplayDelay: 2000,
        useWebkit3d: true,
        transitionSpeed: 400
      };
      var logos_carousel=$(".touchcarousel").touchCarousel(options).data("touchCarousel");
    }
  });
  $('.touchcarousel-container').each(function(){
    if ($(this).find('li').length==1) $(this).parents(".touchcarousel").addClass('touchcarousel--min');
  });


  ////////////////////////////////////////// POPUPS
  $(document).on('click','.open_popup', function() {open_popup($(this).data('popup'), $layout, $overlay)});
  $(document).on('click','.close_popup', function(){$overlay.click()});
  $overlay.on('click', function() {close_popup($layout, $overlay, $popups)});

}); // End ready

function close_popup ($layout, $overlay, $popups) {
  var top=-(parseInt($layout.css('top')));
  $layout.removeClass('noscroll').css('top','');
  $(window).scrollTop(top);
  $overlay.fadeOut(150);
  $popups.fadeOut(150).removeClass('open');
}

function open_popup (popup_data, $layout, $overlay) {
  var $window=$(window),
      scroll_top=$window.scrollTop();
  $layout.addClass('noscroll').css('top',-scroll_top+'px');
  $('#popup_'+popup_data).fadeIn(150).addClass('open');
  $overlay.fadeIn(150);
  $window.scrollTop(0);
}

function check_width (data_width) {
  if ($(window).width()<=data_width) return true;
  return false;
}

function programm_next (next, prev) {
  var page=Number(next.attr('data-page'));
  if (check_width(mobileBreakpoint)) {
    if (page < hallCount()){
      if (page==hallCount()-1) next.addClass('disable');
      next.attr('data-page', (page + 1));
      prev.removeClass('disable').attr('data-page', (page + 1));
      next.parents('table').attr('class', 'page-' + (page + 1));
      // то, что выше - может не работать как надо
      showTdOfTable([page+1]);
    }
  } else if (check_width(midScreenBreakpoint)) {
    console.log('next', page);
    // if (page==2) {
      next.addClass('disable').attr('data-page',2);
      prev.removeClass('disable').attr('data-page',2);
      next.parents('table').attr('class','page-2');
      showTdOfTable(hallPages()[1]);
    // }
  }
}

function programm_prev (prev, next) {
  var page=Number(prev.attr('data-page'));
  if (check_width(mobileBreakpoint)) {
    if (page>1){
      if (page==2) prev.addClass('disable');
      prev.attr('data-page', (page - 1));
      next.removeClass('disable').attr('data-page', (page - 1));
      prev.parents('table').attr('class', 'page-' + (page - 1));
      // то, что выше - может не работать как надо
      showTdOfTable([page-1]);
    }
  } else if (check_width(midScreenBreakpoint)) {
    console.log('prev', page);
    // if (page==1) {
      next.removeClass('disable').attr('data-page',1);
      prev.addClass('disable').attr('data-page',1);
      next.parents('table').attr('class','page-1');
      showTdOfTable(hallPages()[0]);
    // }
  }
}

function showTdOfTable(halls) {
  showHeadOfTable(halls);
  hideAllTd();
  halls.map(function(hall) {
    $("td[data-hall=" + hall + "]").show();
  });
  hidePassedForHalls(halls);
}

function hideAllHeads() {
  $("th[data-hall]").hide();
}

function showHeadOfTable(halls) {
  hideAllHeads();
  halls.map(function(hall) {
    $("th[data-hall=" + hall + "]").show();
  });
}

function hidePassedForHalls(halls) {
  $('.programm__schedule__lectures').removeClass('passed_tr');
  var current_time = parseInt($('.current_time_line').closest('tr').data('time'));
  var $highest_tr;
  var trs = [];
  halls.map(function(hall) {
    var lastActiveLecture, $tr;
    $('.programm__schedule__lectures td[data-hall=' + hall + ']').each(function(index, td) {
      var $parent_tr = $(td).closest('tr');
      var time = $parent_tr.data('time');
      var $lecture = $(td).find('.programm__schedule__lectures__lecture');
      var $timeslot = $parent_tr.find('.programm__time');

      if(time > current_time) return false;
      if($lecture.length) {
        if(!$lecture.hasClass('passed') && !lastActiveLecture) {
          lastActiveLecture = $lecture;
          $tr = $parent_tr;
        }
      } else if($timeslot.length && time < current_time && !lastActiveLecture) {
        $tr = $parent_tr;
      }
    });
    trs.push($tr);
  });
  trs.forEach(function(el) {
    if (!_.isUndefined(el)) {
      if(!$highest_tr) $highest_tr = el;
      else if(el.data('time') < $highest_tr.data('time')) $highest_tr = el;
    }
  });
  if($highest_tr) {
    $highest_tr.prevAll().addClass('passed_tr');
  } else {
    $('.show_passed').hide();
  }
  changeCurrentTimeLine();
}

function hideAllTd() {
  $("td[data-hall]").hide();
}
/*
 function contacts_next (next, prev) {
 var page=Number(next.attr('data-page')), contacts_info=$('#contacts_info');
 if (page<3) {
 next.attr('data-page',(page+1));
 prev.removeClass('disable').attr('data-page',(page+1));
 contacts_info.find('li').hide().eq(page).show();
 }
 if (page==2) {
 next.addClass('disable');
 }
 }

 function contacts_prev (prev, next) {
 var page=Number(next.attr('data-page')), contacts_info=$('#contacts_info');
 if (page>1) {
 prev.attr('data-page',(page-1));
 next.removeClass('disable').attr('data-page',(page-1));
 contacts_info.find('li').hide().eq(page-2).show();
 }
 if (page==2) {
 prev.addClass('disable');
 }
 }
 */
function showUser(_this) {
  $(_this).parent().toggleClass('open');
}
