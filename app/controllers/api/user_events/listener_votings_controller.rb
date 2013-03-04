class Api::UserEvents::ListenerVotingsController < Api::UserEvents::ApplicationController
  def create
    resource_user_event.listener_votings.vote_by current_user
  end
end