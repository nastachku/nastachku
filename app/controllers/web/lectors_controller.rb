class Web::LectorsController < Web::ApplicationController
  def index
    if params[:q]
      @topic = Topic.find params[:q][:topics_id_eq]
      @lectors = User.activated.as_lectors.by_created_at.ransack(params[:q]).result
      title @topic
    else
      @lectors = User.activated.as_lectors.by_created_at
    end
  end
end
