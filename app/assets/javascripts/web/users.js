
jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
  });

  $('#filter_for_users').on('change.fs', function(){
    $.getScript($('#filter_for_users option:selected').data("href"));
    return false;
  });
})

$(document).ready(function (e) {
  $("#submit").attr("disabled", true);
  $("#privacy").click(function () {
    $("#submit").attr("disabled", !this.checked);
  });
});
