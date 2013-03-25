
class Web::Admin::PagesController < Web::Admin::ApplicationController

  def new
    @page = Page.new
  end

  def create
    @page = ::Admin::PageEditType.new params[:page]
    @page.changed_by = current_user

    if @page.save
      flash_success
      redirect_to edit_admin_page_path(@page)
    else
      flash_error
      render :new
    end
  end

  def show
    @page = Page.find params[:id]
  end

  def index
    @search = Page.ransack(params[:q])
    if params[:q]
      @pages = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
    else
      @pages = @search.result.web.page(params[:page]).per(configus.pagination.admin_per_page)
    end
  end

  def edit
    @page = Page.find params[:id]
  end

  def update
    @page = ::Admin::PageEditType.find params[:id]
    @page.changed_by = current_user

    if @page.update_attributes params[:page]
      flash_success
      redirect_to edit_admin_page_path(@page)
    else
      flash_error
      render :new
    end
  end

  def destroy
    @page = Page.find params[:id]
    @page.destroy
    redirect_to admin_pages_path
  end

end
