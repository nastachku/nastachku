
class Web::Admin::NewsController < Web::Admin::ApplicationController

  def new
    @news = News.new
  end

  def create
    @news = ::Admin::NewsEditType.new params[:news]
    @news.changed_by = current_user

    if @news.save
      flash_success
      redirect_to edit_admin_news_path(@news)
    else
      flash_error
      render :new
    end
  end

  def show
    @news = News.find params[:id]
  end

  def index
    @search = News.ransack(params[:q])
    if params[:q]
      @news = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
    else
      @news = @search.result.web.page(params[:page]).per(configus.pagination.admin_per_page)
    end
  end

  def edit
    @news = News.find params[:id]
  end

  def update
    @news = ::Admin::NewsEditType.find params[:id]
    @news.changed_by = current_user

    if @news.update_attributes params[:news]
      flash_success
      redirect_to edit_admin_news_path(@news)
    else
      flash_error
      render :new
    end
  end

  def destroy
    @news = News.find params[:id]
    @news.destroy

    redirect_to admin_news_index_path
  end

end
