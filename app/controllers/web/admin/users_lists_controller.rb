class Web::Admin::UsersListsController < Web::Admin::ApplicationController
  def show
    @users = upload_list_from_file params[:file]
  end
end
