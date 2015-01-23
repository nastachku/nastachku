class Web::NewsController < Web::ApplicationController
  def index
    @news = News.web
  end

end