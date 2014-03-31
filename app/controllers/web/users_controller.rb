# -*- coding: utf-8 -*-
class Web::UsersController < Web::ApplicationController
  respond_to :html, :json
  respond_to :js, only: :index
  caches_action :index, unless: :signed_in?, :cache_path => Proc.new {|c|
    user = User.activated.attended.alphabetically.order('updated_at DESC').limit(1).first
    {:tag => "#{user.updated_at.to_i if user}_#{c.params.except(:_).to_s}"}
  }

  def index
    @search = User.ransack(params)
    @users = @search.result.activated.attended.alphabetically
    #FIXME некрасиво
    @users = @users.as_lectors if params[:s] and params[:s].include? 'as_lectors'
    #FIXME придумать как задекорировать выборку

    respond_with(@users)
  end

  def new
    @user = UserRegistrationType.new

    if registration_by_soc_network?
      @user = UserPopulator.via_facebook(@user, session_auth_hash)
    end

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
      if registration_by_soc_network?
        @user.authorizations << build_authorization(session_auth_hash)
        @user.activate
        clear_session_auth_hash
        sign_in @user
        redirect_to welcome_index_path
      else
        token = @user.create_auth_token
        UserMailer.confirm_registration(@user.id, token.id).deliver
        flash_success
        redirect_to new_session_path
      end
    else
      flash_error
      render action: "new"
    end
  rescue Net::SMTPAuthenticationError, SocketError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError, Errno::ECONNREFUSED => e
    flash[:error] = t(".flash.controllers.web.users.create.net_error") + e.message
  end

  def attend
    current_user.attend
    redirect_to edit_account_path
  end

end
