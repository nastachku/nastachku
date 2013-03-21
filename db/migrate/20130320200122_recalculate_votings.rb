class RecalculateVotings < ActiveRecord::Migration
  def up
    Lecture.find_each do |lecture|
      lecture.lecture_votings_count = lecture.lecture_votings.count
      lecture.listener_votings_count = lecture.listener_votings.count
      lecture.save!
    end
  end

  def down
  end
end
