
class Web::HomeController < Web::ApplicationController

  def index
    @news = News.web
  end

end