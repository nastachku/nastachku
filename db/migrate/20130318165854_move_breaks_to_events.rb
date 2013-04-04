class MoveBreaksToEvents < ActiveRecord::Migration
  def up
    if defined?(Event::Break)
      Event::Break.transaction do
        Event::Break.find_each do |event_break|
          event = Event.new do |e|
            e.title = event_break.title
          end
          event.save!
        end
      end
    end

  end

  def down
  end
end
