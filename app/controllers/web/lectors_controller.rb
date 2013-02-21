class Web::LectorsController < Web::ApplicationController
  def index
    if params[:q]
      @topic = Topic.find params[:q][:topics_id_eq]
      @lectors = User.as_lectors.by_created_at.ransack(params[:q]).result
    else
      @lectors = User.as_lectors.by_created_at
    end
  end
end
