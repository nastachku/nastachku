jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
    optionTemplate: function(optionEl) {
      return '<span class="before_select_option" style="background-image: url(\'' + optionEl.data('icon') + '\');"></span><span class="select_option">' + optionEl.text() + '</span>';
    }
  });

  $('#filter_by_workshop').on('change.fs', function(){
    $.ajax({
      url: Routes.lectures_path(),
      type: "GET",
      dataType: "script",
      data: {workshop_id_eq: $('#filter_by_workshop option:selected').val()},
      success: function() {
        window.pluso.start();
      }
    })
  });

  $('#lectures').on('click', '.sorting a', function() {
    $.getScript(this.href,  function( data, textStatus, jqxhr ) {
      window.pluso.start();
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
        $(self).removeClass("added");
        $(self).siblings('.lecture_added').hide();
      }
     })
   });
});
