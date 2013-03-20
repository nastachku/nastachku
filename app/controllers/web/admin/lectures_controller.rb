class Web::Admin::LecturesController < Web::Admin::ApplicationController
  def index
    @search = Lecture.ransack(params[:q])
    @lectures = @search.result.admin.page(params[:page]).per(20)
  end

  def new
    @type = ::Admin::LectureEditType.new
  end

  def create
    @type = ::Admin::LectureEditType.new params[:lecture]
    @type.changed_by = current_user
    if @type.save
      flash_success
      redirect_to edit_admin_lecture_path(@type)
    else
      flash_error
      render :new
    end
  end

  def edit
    @type = ::Admin::LectureEditType.find params[:id]
  end

  def update
    @type = ::Admin::LectureEditType.find params[:id]
    @type.changed_by = current_user
    if @type.update_attributes params[:lecture]
      flash_success
      redirect_to edit_admin_lecture_path(@type)
    else
      flash_error
      render :edit
    end
  end
end