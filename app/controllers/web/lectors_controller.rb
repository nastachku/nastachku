class Web::LectorsController < Web::ApplicationController
  def index
    @lectors = User.activated.as_lectors.by_created_at.ransack(params).result
    @workshops = Workshop.web
  end
end
