class CommentsController < ApplicationController

  respond_to :js
  before_action :authenticate!, only: [:index, :create, :edit, :update, :new, :destroy]

  def index
    @post = Post.friendly.find(params[:post_id])
    @topic = @post.topic
    @comments = @post.comments.page(params[:page]).per(4)
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find_by(slug: params[:post_id])
    @topic = Topic.find_by(slug: params[:topic_id])
    @comment = current_user.comments.build(comment_params.merge(post_id: @post.id))
    @new_comment = Comment.new
    authorize @comment

  if @comment.save
    CommentBroadcastJob.perform_later("create", @comment)
    flash.now[:success] = "You've created a new comment."
    # binding.pry
    #   redirect_to topic_post_comments_path(@topic, @post)
  else
    flash.now[:danger] = @comment.errors.full_messages
  end
end

  def edit
    @post = Post.find_by(slug: params[:post_id])
    @topic = Topic.find_by(slug: params[:topic_id])
    @comment = Comment.find_by(id: params[:id])
    authorize @comment
  end

  def update
    @post = Post.find_by(slug: params[:post_id])
    @topic = Topic.find_by(slug: params[:topic_id])
    @comment = Comment.find_by(id: params[:id])
    authorize @comment

    if @comment.update(comment_params)
      CommentBroadcastJob.perform_later("update", @comment)
      flash[:success] = "You've updated a comment."
    else
      flash[:danger] = @comment.errors.full_messages
      #redirect_to edit_topic_post_comment_path(@topic, @post, @comment)
    end
  end

  def destroy
    @post = Post.find_by(slug: params[:post_id])
    @topic = Topic.find_by(slug: params[:topic_id])
    @comment = Comment.find_by(id: params[:id])
    authorize @comment

    if @comment.destroy
      CommentBroadcastJob.perform_now("destroy", @comment)
      flash[:success] = "You've deleted a comment."
     #//redirect_to topic_post_comments_path(@topic, @post)
    end
  end

  private

  def comment_params

    params.require(:comment).permit(:image,:body)

  end

end
