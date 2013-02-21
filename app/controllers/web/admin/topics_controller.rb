class Web::Admin::TopicsController < Web::Admin::ApplicationController
  def index
    @topics = Topic.web
  end

  def new
    @topic = ::Admin::TopicEditType.new
  end

  def edit
    @topic = ::Admin::TopicEditType.find params[:id]
  end

  def create
    @topic = ::Admin::TopicEditType.new params[:topic]
    if @topic.save
      flash_success
      redirect_to admin_topics_path
    else
      flash_error
      render :new
    end
  end

  def update
    @topic = ::Admin::TopicEditType.find params[:id]
    if @topic.update_attributes params[:topic]
      flash_success
      redirect_to admin_topics_path
    else
      flash_error
      render :edit
    end
  end

  def destroy
    @topic = Topic.find params[:id]
    @topic.destroy
    redirect_to admin_topic_path
  end
end
