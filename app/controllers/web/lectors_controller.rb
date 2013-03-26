class Web::LectorsController < Web::ApplicationController
  def index
    @lectors = User.activated.as_lectors.visible.by_created_at.ransack(params).result
    @topics = Topic.web
  end
end
