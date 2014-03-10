jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
    optionTemplate: function(optionEl) {
      return '<span class="before_select_option" style="background-image: url(\'' + optionEl.data('icon') + '\');"></span><span class="select_option">' + optionEl.text() + '</span>';
    }
  });

  $('#filter_by_workshop').on('change.fs', function(){
    $.ajax({
      url: Routes.lectures_path,
      type: "GET",
      dataType: "script",
      data: {workshop_id_eq: $('#filter_by_workshop option:selected').val()},
    })
  });

  $('#lectures').on('click', '.sorting a', function() {
    $.getScript(this.href);
    return false;
  });

  $('#add_to_favorites').on('click', function(){
    $.ajax({
      url: Routes.api_lecture_listener_votings_path($(this).data('id')),
      type: "POST",
      dataType: "json",
      success: function() {
        $("#add_to_favorites").addClass("added");
        $("#lecture_added").show();
      }
    })
  });

  $('#remove_from_favorites').on('click', function() {
    $.ajax({
      url: Routes.api_lecture_listener_votings_path($(this).data('id')),
      type: "DELETE",
      dataType: "json",
      success: function() {
        $('#remove_from_favorites').removeClass("added");
        $('#lecture_added').hide();
      }
     })
   });
});
