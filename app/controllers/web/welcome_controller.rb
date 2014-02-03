#encoding: utf-8
class Web::WelcomeController < Web::ApplicationController
  def index
    @news = News.last(3)
    @lectors = UserDecorator.decorate(User.as_lectors.in_carousel.activated.shuffle)
  end

end
