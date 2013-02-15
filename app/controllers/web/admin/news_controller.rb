
class Web::Admin::NewsController < Web::Admin::ApplicationController

  def new
    @news = News.new
  end

  def create
    @news = NewsEditType.new params[:news]

    if @news.save
      flash_success

      redirect_to admin_news_path(@news)
    else
      flash_error

      render "new"
    end
  end

  def show
    @news = News.find params[:id]
  end

  def index
    @news = News.web
  end

  def edit
    @news = News.find params[:id]
  end

  def update
    @news = NewsEditType.find params[:id]

    if @news.update_attributes params[:news]
      flash_success

      redirect_to admin_news_path(@news)
    else
      flash_error

      render "new"
    end
  end

  def destroy
    @news = News.find params[:id]
    @news.delete

    redirect_to admin_news_index_path
  end

end