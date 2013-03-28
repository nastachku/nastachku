#enable chosen js
$('.chosen-select').each ->
  $(@).select2
    allowClear: true
    placeholder: $(@).data('placeholder')

# take user edit link
changeUserEditLink = (id) ->
  $("#lector-name").attr({href: Routes.edit_admin_user_path(id)})

$(document).ready ->
  user_id = $("#lecture_user_id option:selected").attr("value")
  if(typeof user_id != "undefined")
    changeUserEditLink(user_id)

  $("#lecture_user_id").on "change", (e) ->
    changeUserEditLink(e.val)