class MoveVotingForLectures < ActiveRecord::Migration
  def up
    Voting.transaction do
      Voting.find_each do |voting|
        lecture = Lecture.find_by_title! voting.voteable.title
        voting.voteable = lecture
        voting.save!
      end
    end
  end

  def down
  end
end
