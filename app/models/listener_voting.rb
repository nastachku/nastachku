class ListenerVoting < Voting
  belongs_to :voteable, polymorphic: true, counter_cache: true
end