$('.admin-user-edit-form').submit ->
  state_event = $(this).find('#user_state_event').val()
  has_lectures = gon? && gon.user_events_count > 0
  if state_event == 'deactivate' && has_lectures
    return confirm('У данного пользователя есть доклады, при блокировке доклады будут скрыты с сайта. Заблокировать пользователя?')