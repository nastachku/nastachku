# -*- coding: utf-8 -*-
class Web::Registrator::UsersController < Web::Registrator::ApplicationController
  def index
    query = { s: 'last_name asc' }.merge(params[:q] || {})
    @search = User.paid.without_badge.ransack(query)
    @users = UserDecorator.decorate_collection @search.result.page(params[:page]).per(50)
  end

  def with_badge
    query = { s: 'last_name asc' }.merge(params[:q] || {})
    @search = User.paid.with_badge.ransack(query)
    @users = UserDecorator.decorate_collection @search.result.page(params[:page]).per(50)
  end

  def new
    @user = User.new
  end

  def create
    @user = ::Admin::UserEditType.new(params[:user])
    @user.changed_by = current_user
    @user.city = "Зарегистрирован на конференции"
    rand_string = (0...6).map { ('a'..'z').to_a[rand(26)] }.join
    last_id = User.last.id
    @user.email = "#{last_id + 1}#{rand_string}@nastachku.fake"

    if @user.save
      @user.activate
      @user.pay_part
      flash_success
      redirect_to registrator_root_path
    else
      flash_error
      render :new
    end
  end

  def give_badge
    user = User.find params[:id]
    user.give_badge
    redirect_to registrator_root_path
  end
end
