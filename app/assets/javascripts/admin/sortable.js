$(function(){
  $('.sortable').each(function() {

    var connectClass = '.' + $(this).attr('class').replace(/\s/g, '.');
    $(this).sortable({

      helper: function(e, ui) {
        ui.children().each(function() {
          $(this).width($(this).width());
        });
        return ui;
      },
      connectWith: connectClass,
      update: function(e, ui) {
        var ids = [],
          cont = ui.item.closest('ul, tbody'),
          url = cont.attr('data-update-url'),
          group = cont.closest('li, tr').attr('data-id')
        ;

        cont.children().each(function() {
          var id = $(this).attr('data-id');
          ids.push(id);
        });

        $.ajax({
          type: "post",
          url: url,
          data: {
            group: group,
            ids: ids,
            _method: 'put'
          },
          dataType: 'json'
        });
      }
    })
  });
});