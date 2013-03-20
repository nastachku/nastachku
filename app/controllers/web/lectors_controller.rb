class Web::LectorsController < Web::ApplicationController
  def index
    @lectors = UserDecorator.decorate_collection(User.activated.as_lectors.by_created_at.ransack(params).result)
    @topics = Topic.web
  end
end
