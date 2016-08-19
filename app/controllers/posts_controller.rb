class PostsController < ApplicationController
respond_to :js
before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).find_by(slug: params[:topic_id])
    @posts = @topic.posts.page(params[:page]).per(6)
    @new_post = Post.new
  end

  def new
    @post = Post.new
    @topic = Topic.find_by(slug: params[:topic_id])
    @new_post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find_by(slug: params[:topic_id])
    @post = current_user.posts.build(post_params.merge(topic_id: @topic.id))
    authorize @post

    if @post.save
      flash.now[:success] = "You've created a new post."
      #redirect_to topic_posts_path(@topic)
    else
      flash.now[:danger] = @post.errors.full_messages
    end
  end

  def edit
    @post = Post.find_by(slug: params[:id])
    @topic = Topic.find_by(slug: params[:topic_id])
    authorize @post
  end

  def update
    @post = Post.find_by(slug: params[:id])
    @topic = Topic.find_by(slug: params[:topic_id])

    if @post.update(post_params)
      flash[:success] = "You've updated a new post."
      redirect_to topic_posts_path(@topic)
    else
      flash[:danger] = @post.errors.full_messages
      redirect_to edit_topic_post_path(@topic, @post)
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    @topic = @post.topic
    authorize @post

    if @post.destroy
      flash[:success] = "You've deleted a post."
      redirect_to topic_posts_path(@topic)
    end
  end

  private

  def post_params
    params.require(:post).permit(:image,:title,:body)
  end
end
