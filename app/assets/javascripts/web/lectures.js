jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
    optionTemplate: function(optionEl) {
      return '<span class="before_select_option" style="background-image: url(\'' + optionEl.data('icon') + '\');"></span><span class="select_option">' + optionEl.text() + '</span>';
    }
  });

  $('#filter_by_workshop option[value=' + $.url().param("workshop_id_eq") + ']').prop('selected', true).trigger('change');

  $('#filter_by_workshop').on('change.fs', function(){
    $.ajax({
      url: Routes.lectures_path(),
      type: "GET",
      dataType: "script",
      data: {
        q: {
          workshop_id_eq: $('#filter_by_workshop option:selected').val()
        }
      },
      success: function() {
        startShare42();
        window.history.pushState('string', 'Доклады', Routes.lectures_path() + "?q[workshop_id_eq]=" + $('#filter_by_workshop option:selected').val());
      }
    })
  });

  $('#lectures').on('click', '.sorting a', function() {
    $.getScript(this.href,  function( data, textStatus, jqxhr ) {
      startShare42();
    });
    return false;
  });
});
