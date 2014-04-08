class Web::Registrator::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.paid
  end
end
