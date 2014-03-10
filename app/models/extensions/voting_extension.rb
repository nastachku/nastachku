module Extensions
  module VotingExtension

    def voted_by?(user)
      voting = Voting.where(user_id: user.id).first
      voting.present?
    end

    def vote_by(user)
      return false if voted_by? user
      voting = proxy_association.build(user: user)
      voting.save
    end

    def unvote_by(user)
      return false unless voted_by? user
      voting = where(user_id: user.id).first
      voting.destroy
    end

  end
end
