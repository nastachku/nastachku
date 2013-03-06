class Web::LectorsController < Web::ApplicationController
  def index
    @lectors = User.activated.as_lectors.by_created_at.ransack(params).result
    if params[:q]
      @topic = Topic.find params[:topics_id_eq]
      title @topic
    end
  end
end
