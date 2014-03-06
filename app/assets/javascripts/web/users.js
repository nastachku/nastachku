
jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
  });
  
  $('#filter_for_users').on('change.fs', function(){
    $.getScript($('#filter_for_users option:selected').data("href"));
    return false;
  });
});
