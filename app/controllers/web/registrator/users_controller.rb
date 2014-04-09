class Web::Registrator::UsersController < Web::Registrator::ApplicationController
  def index
    query = { s: 'last_name asc' }.merge(params[:q] || {})
    @search = User.paid.ransack(query)
    @users = @search.result.page(params[:page]).per(50)
  end

  def give_badge
    user = User.find params[:id]
    user.give_badge
    redirect_to registrator_users_path
  end
end
