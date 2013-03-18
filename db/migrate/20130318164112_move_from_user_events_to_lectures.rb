class MoveFromUserEventsToLectures < ActiveRecord::Migration
  def up
    UserEvent.transaction do
      UserEvent.find_each do |user_event|
        lecture = Lecture.new do |l|
          l.title = user_event.title
          l.thesises = user_event.thesises
          l.created_at = user_event.created_at
          l.updated_at = user_event.updated_at
          l.listener_votings_count = user_event.listener_votings_count
          l.lecture_votings_count = user_event.lecture_votings_count
          l.user_id = user_event.speaker_id
          l.workshop_id = user_event.workshop_id
          l.state = user_event.state
          l.presentation = user_event.presentation
        end
        lecture.save!
      end
    end
  end

  def down
  end
end
