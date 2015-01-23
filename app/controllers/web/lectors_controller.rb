class Web::LectorsController < Web::ApplicationController
  def index
    @lectors = UserDecorator.decorate(User.activated.attended.as_lectors.visible.by_created_at.ransack(params[:q]).result(distinct: true))
    @workshops = Workshop.web
  end
end
