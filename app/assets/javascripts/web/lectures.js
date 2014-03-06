jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
    optionTemplate: function(optionEl) {
      return '<span class="before_select_option" style="background-image: url(\'' + optionEl.data('icon') + '\');"></span><span class="select_option">' + optionEl.text() + '</span>';
    }
  });

  $('#filter_by_workshop').on('change.fs', function(){
    $.ajax({
      url: gon.remote_filter_action,
      type: "GET",
      dataType: "script",
      data: {workshop_id_eq: $('#filter_by_workshop option:selected').val()},
    })
  });
});
