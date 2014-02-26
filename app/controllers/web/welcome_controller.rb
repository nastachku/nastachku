#encoding: utf-8
class Web::WelcomeController < Web::ApplicationController
  def index
    @news = News.last(3)
    @lectors = UserDecorator.decorate_collection User.as_lectors.activated.attended.shuffle.first 4
  end

end
