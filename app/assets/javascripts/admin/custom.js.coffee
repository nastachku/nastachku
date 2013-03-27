window.onload = ->
  delay = (ms, func) -> setTimeout func, ms
  delay 4000, -> $('.alert').fadeOut('slow')

# take user edit link

changeUserEditLink = (id) ->
  $("#lector-name").attr({href: "/admin/users/" + id + "/edit"})

$(document).ready ->
  user_id = $("#lecture_user_id option:selected").attr("value")
  changeUserEditLink(user_id)

  $("#lecture_user_id").on "change", (e) ->
    changeUserEditLink(e.val)