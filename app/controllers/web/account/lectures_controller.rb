class Web::Account::LecturesController < Web::Account::ApplicationController

  def new
    @user = UserLecturesEditType.find current_user
    @user.lectures.build
  end

  def create
    @user = UserLecturesEditType.find current_user
    @user.changed_by = current_user
    if @user.update_attributes params[:user]
      flash_success
      redirect_to root_path
    else
      flash_error
      render :new
    end
  end

  def update
    @lecture = current_user.lectures.find params[:id]
    @lecture.changed_by = current_user
    @updated = @lecture.update_attributes params[:lecture]
    render :edit, layout: false
  end
end