class Web::Admin::UsersController < Web::Admin::ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = ::Admin::UserEditType.new(params[:user])
    @user.changed_by = current_user

    if @user.save
      flash_success
      redirect_to edit_admin_user_path(@user)
    else
      flash_error
      render :new
    end
  end

  def index
    query = { s: 'created_at desc' }.merge(params[:q] || {})
    @search = User.ransack(query)
    @users = @search.result.includes(:promo_code).page(params[:page]).per(50)
  end

  def show
    @user = ::Admin::UserEditType.find params[:id]
  end

  def edit
    @user = ::Admin::UserEditType.find params[:id]
    gon.user_events_count = @user.lectures.count
  end

  def update
    @user = ::Admin::UserEditType.find(params[:id])
    @user.changed_by = current_user

    if @user.update_attributes params[:user]
      flash_success
      redirect_to edit_admin_user_path(@user)
    else
      flash_error
      gon.user_events_count = @user.lectures.count
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to admin_users_path
  end

  def pay_part
    @user = User.find params[:user_id]
    @user.pay_part
    #FIXME создать функцию
    @user.reason_to_give_ticket = UsersList.find(params[:id]).description
    @user.save
    redirect_to admin_users_list_path params[:id]
  end

  def create_paid_part
    @user = UserCreatePaidType.new params[:user]
    if @user.save
      @user.pay_part
      UserMailer.sent_after_create @user.id
      redirect_to admin_users_list_path params[:id]
    else
      redirect_to admin_users_list_path params[:id]
    end
  end
end
