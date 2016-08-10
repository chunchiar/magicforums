class CommentsController < ApplicationController

before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @post = Post.includes(:comments).find_by(id: params[:post_id])
    @topic = @post.topic
    @comments = @post.comments.order("created_at DESC")
  end

  def new
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = Comment.new
  end

  def show
    @post = Post.find_by(id:params[:post_id])
    @topic = @post.topic
    @comment = Comment.find_by(id:params[:id])
  end

    def create
      @post = Post.find_by(id: params[:post_id])
      @topic = @post.topic
      @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))

      if @comment.save
        flash[:success] = "You've created a new comment."
        redirect_to topic_post_comments_path(@topic, @post)
      else
        flash[:danger] = @comment.errors.full_messages
        render :new
      end
    end

    def edit
      @post = Post.find_by(id: params[:post_id])
      @topic = @post.topic
      @comment = Comment.find_by(id: params[:id])
    end

    def update
      @post = Post.find_by(id: params[:post_id])
      @topic = @post.topic
      @comment = Comment.find_by(id: params[:id])

      if @comment.update(comment_params)
        flash[:success] = "You've updated a comment."
        redirect_to topic_post_comments_path(@topic, @post,@comment)
      else
        flash[:danger] = @comment.errors.full_messages
        redirect_to edit_topic_post_comment_path(@topic, @post, @comment)
      end
    end

    def destroy
     @post = Post.find_by(id: params[:post_id])
       @topic = @post.topic
      @comment = Comment.find_by(id: params[:id])

      if @comment.destroy
        redirect_to topic_post_comments_path(@topic, @post)
      end
    end

    private

    def comment_params

      params.require(:comment).permit(:body)

    end

  end
