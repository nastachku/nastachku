class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    query = { s: 'created_at desc' }.merge(params[:q] || {})
    @search = User.ransack(query)
    @users = @search.result
    @users = @users.joins(:lectures) if lectors_only?
    @users = @users.includes(:promo_code).page(params[:page]).per(50)
  end

  def show
    @user = ::Admin::UserEditType.find params[:id]
  end

  def edit
    @user = ::Admin::UserEditType.find params[:id]
    gon.user_lectures_count = @user.lectures.count
  end

  def update
    @user = ::Admin::UserEditType.find(params[:id])
    @user.changed_by = current_user

    if @user.update_attributes params[:user]
      flash_success
      redirect_to edit_admin_user_path(@user)
    else
      flash_error
      gon.user_lectures_count = @user.lectures.count
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to admin_users_path
  end

  def tickets
    @user = User.find params[:id]
    @ticket_code_activation_form = ::Admin::UserTicketCodeActivationType.new
  end

  def activate_code
    @user = User.find params[:id]
    @ticket_code_activation_form = ::Admin::UserTicketCodeActivationType.new(params[:admin_user_ticket_code_activation_type])
    if @ticket_code_activation_form.valid?
      AdminTicketActivationService.new(@user).activate_code(@ticket_code_activation_form.code)
      redirect_to action: :tickets
    else
      render action: :tickets
    end
  end

  def cancel_ticket
    @user = User.find params[:id]
    ticket = case params[:ticket_id].to_i
             when @user.ticket.try(:id)
               @user.ticket
             when @user.afterparty_ticket.try(:id)
               @user.afterparty_ticket
             end
    if ticket
      ticket.cancel
    end
    redirect_to action: :tickets
  end

  def pay_part
    @user = User.find params[:user_id]
    @user.pay_part
    #FIXME создать функцию
    @user.reason_to_give_ticket = UsersList.find(params[:id]).description
    @user.save
    UserMailer.sent_after_create_if_user_present(@user.id).deliver_in(10.seconds) if Rails.env.production?
    redirect_to admin_users_list_path params[:id]
  end

  def create_paid_part
    @user = UserCreatePaidType.new params[:user]
    if @user.save
      @user.pay_part
      User::PromoCode.create(code: generate_promo_code, user_id: @user.id)
      UserMailer.sent_after_create(@user.id).deliver_in(10.seconds) if Rails.env.production?
      redirect_to admin_users_list_path params[:id]
    else
      redirect_to admin_users_list_path params[:id]
    end
  end

  private

  def lectors_only?
    params[:category] == "lectors"
  end
end
