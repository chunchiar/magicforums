class TopicsController < ApplicationController

  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topics = Topic.page(params[:page]).per(6)
    @new_topic = Topic.new
  end

  def new
    @topic = Topic.new
    @new_topic = Topic.new
    authorize @topic
  end

  def create
    @topic = current_user.topics.build(topic_params)
    authorize @topic

    if @topic.save
      flash[:success] = "You've created a new topic."
      redirect_to topics_path
    else
      flash[:danger] = @topic.errors.full_messages
      redirect_to new_topic_path
    end
  end

  def edit
    @topic = Topic.friendly.find(params[:id])
    #$prevURL = request.referer;
    #session[:return_to] ||= request.referer
    authorize @topic
  end

  def update
    @topic = Topic.friendly.find(params[:id])
    authorize @topic

    if @topic.update(topic_params)
      flash[:success] = "You've updated a topic."
      redirect_to topics_path
    else
      flash[:danger] = @topic.errors.full_messages
    end
  end

  def destroy
    @topic = Topic.friendly.find(params[:id])
    authorize @topic
    if @topic.destroy
      flash[:success] = "Topic deleted"
      redirect_to topics_path
    else
      redirect_to topic_path(@topic)
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :description)
  end

end
