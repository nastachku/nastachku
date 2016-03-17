# -*- coding: utf-8 -*-
class Web::UsersController < Web::ApplicationController
  respond_to :html, :json
  respond_to :js, only: :index

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.activated.participants.alphabetically
    @users = @users.lectors if params[:q] && params[:q]['s'].include?('only_lectors')

    @meta_tags = {
      title: "«Стачка 2016» — участники",
      description: "Полный список участников, зарегистрировавшихся на международную IT-конференцию «Стачка!».",
      keywords: "стачка участники"
    }

    respond_with @users
  end

  def new
    @user = UserRegistrationType.new
    @meta_tags = {
      title: "«Стачка 2016» — форма регистрации участника",
      description: "Участие в конференции – платное. Условия допуска: документ, удостоверяющий личность.",
      keywords: "стачка регистрация"
    }
  end

  def activate
    token = User::AuthToken.find_by_authentication_token(params[:auth_token])
    unless token
      flash[:error] = t :error, scope: [:flash, :controllers, :web, :users, :activate]
      return redirect_to welcome_index_path
    end
    if token.user
      token.user.activate!
      sign_in token.user
      flash_success
      redirect_to edit_account_path
    else
      flash_error
      redirect_to new_session_path
    end
  end

  def create
    @user = UserRegistrationType.new params[:user]
    @user.show_as_participant = true
    if @user.save
      User::PromoCode.create({ code: generate_promo_code, user_id: @user.id })
      @user.activate
      sign_in @user
      UserMailer.confirm_registration(@user.id).deliver_in(10.seconds)
      flash_success
      GoogleAnalyticsClient.register_event(@user)
      redirect_to edit_account_path(anchor: :orders)
    else
      flash_error
      render action: "new"
    end
  rescue Net::SMTPAuthenticationError, SocketError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError, Errno::ECONNREFUSED => e
    flash[:error] = t(".flash.controllers.web.users.create.net_error") + e.message
  end

end
