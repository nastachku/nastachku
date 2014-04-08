class Web::Admin::UsersListsController < Web::Admin::ApplicationController
  def show
    @users_list = UsersList.find params[:id]
    list = upload_list_from_file UsersList.find(params[:id]).file.file.file #причуды carrierwave
    @users = UserDecorator.decorate_collection list[0]
    @other_users = list[1]
  end

  def index
    @users_lists = UsersList.all
  end

  def new
    @users_list = UsersList.new
  end

  def create
    @users_list = UsersList.new params[:users_list]
    if @users_list.save
      redirect_to admin_users_list_path @users_list
    else
      render action: :new
    end
  end

  def destroy
    @users_list = UsersList.find params[:id]
    @users_list.destroy
    redirect_to admin_users_lists_path
  end
end
