class Web::Account::LecturesController < Web::Account::ApplicationController

  def new
    @user = UserLecturesEditType.find current_user.id
    @user.lectures.build
  end

  def create
    @user = UserLecturesEditType.find current_user.id
    @user.changed_by = current_user
    if @user.update_attributes params[:user]
      flash_success
      redirect_to user_lectures_path
    else
      flash_error
      render :new
    end
  end

  def update
    @lecture = current_user.lectures.find params[:id]
    @lecture.changed_by = current_user
    if @lecture.update(params[:lecture])
      redirect_to edit_account_path
    else
      render :edit
    end
  end

  def edit
    @lecture = current_user.lectures.find params[:id]

    render :edit
  end
end
