jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
    optionTemplate: function(optionEl) {
      return '<span class="before_select_option" style="background-image: url(\'' + optionEl.data('icon') + '\');"></span><span class="select_option">' + optionEl.text() + '</span>';
    }
  });

  $('#filter_user_lectures_by_workshop option[value=' + $.url().param("workshop_id_eq") + ']').prop('selected', true).trigger('change');

  $('#filter_user_lectures_by_workshop').on('change.fs', function(){
    $.ajax({
      url: Routes.user_lectures_path(),
      type: "GET",
      dataType: "script",
      data: {workshop_id_eq: $('#filter_user_lectures_by_workshop option:selected').val()},
      success: function() {
        startShare42();
        window.history.pushState('string', 'Доклады 2.0', Routes.user_lectures_path() + "?workshop_id_eq=" + $('#filter_user_lectures_by_workshop option:selected').val());
      }
    })
  });

  $('#lectures').on('click', '.sorting a', function() {
    $.getScript(this.href,  function( data, textStatus, jqxhr ) {
      startShare42();
    });
    return false;
  });

  $(document).on('click', '.voting_button:not(".added")', function(){
    var self = this;
    $.ajax({
      url: Routes.api_lecture_lecture_votings_path($(this).data('id')),
      type: "POST",
      dataType: "json",
      success: function() {
        var $votings_count = $(self).siblings('.lecture_voting_count');
        $votings_count.html(parseInt($votings_count.html(), 10) + 1);
        $(self).addClass("added");
        $(self).siblings(".lecture_added").show();
      }
    })
  });

  $(document).on('click', '.voting_button.added', function() {
    var self = this;
    $.ajax({
      url: Routes.api_lecture_lecture_votings_path($(this).data('id')),
      type: "DELETE",
      dataType: "json",
      success: function() {
        var $votings_count = $(self).siblings('.lecture_voting_count');
        $votings_count.html(parseInt($votings_count.html(), 10) - 1);
        $(self).removeClass("added");
        $(self).siblings('.lecture_added').hide();
      }
     })
   });
});
