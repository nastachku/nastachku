class Web::LectorsController < Web::ApplicationController
  def index
    @lectors = UserDecorator.decorate_collection(User.visible.lectors.web.ransack(params[:q]).result(distinct: true))
    @workshops = Workshop.web
  end
end
