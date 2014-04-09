class Web::Admin::UsersListsController < Web::Admin::ApplicationController
  def show
    @users_list = UsersList.find params[:id]
    list = upload_list_from_file UsersList.find(params[:id]).file.file.file #причуды carrierwave
    @users = UserDecorator.decorate_collection list[0]
    @other_users = list[1]
  end

  def accept
    @users_list = UsersList.find params[:id]
    list = upload_list_from_file @users_list.file.file.file
    @users = list[0]
    @other_users = list[1]
    users_not_payed = @users.select { |u| not u.paid_part? }
    @users.each_with_index do |user, i|
      if user.paid_part?
        next
      end
      unless user.reason_to_give_ticket or user.paid_part?
        user.pay_part
        user.reason_to_give_ticket = @users_list.description
        user.save
      end
    end
    Resque.enqueue  BroadcastMailerJobAfterCreate, @users.select { |user| not user.paid_part? }

    @other_users.each_with_index do |other_user, i|
      user = UserCreatePaidType.new(email: other_user[I18n.t('users_lists.data.email').to_sym], first_name: other_user[I18n.t('users_lists.data.fio').to_sym].split(' ')[1], last_name: other_user[I18n.t('users_lists.data.fio').to_sym].split(' ')[0], company: other_user[I18n.t('users_lists.data.company').to_sym], password: generate_password, city: "Ульяновск", reason_to_give_ticket: @users_list.description)
      if user.save
        user.pay_part
        UserMailer.sent_after_create(user.id).deliver_in((10 * (i + 1)).seconds)
        Rails.logger.info "BROADCASTING SEND EMAILS to other users #{user.id}"
      end
    end
    @users_list.accept
    redirect_to admin_users_list_path @users_list
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
