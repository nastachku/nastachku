module CustomUrlHelpers

  def edit_admin_event_cpath(event)
    case event
      when ::UserEvent
        edit_admin_event_path(event)
      when ::Event::Break
        edit_admin_event_break_path(event)
    end
  end

end