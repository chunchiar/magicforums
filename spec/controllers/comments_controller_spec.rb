require 'rails_helper'

  RSpec.describe CommentsController, type: :controller do
    before(:all) do
      @admin = create(:user,:admin)
      @user = create(:user)
      @topic = create(:topic)
      @post = create(:post, user_id: @admin.id, topic_id: @topic.id)
      @comment = create(:comment,user_id: @admin.id, post_id: @post.id)
    end

    describe "index comments" do
      it "should render index" do

        params = { topic_id: @topic.slug, post_id: @post.slug }
        get :index, params: params, session: {id: @user.id}

        expect(subject).to render_template(:index)
        expect(Comment.count).to eql(1)
      end
    end

    describe "create comment" do
      it "should deny if user not logged in" do

        params = { topic_id: @topic.slug, post_id: @post.slug, comment: { body: "New Body" } }
        post :create, xhr: true, params: params

        expect(flash[:danger]).to eql("You need to login first")
      end

      it "should create new comment" do

       session[:id] = @user.id
       params = { topic_id: @topic.slug, post_id: @post.slug, comment: { body: "New Comment" } }
       post :create, xhr: true, params: params

       comment = Comment.all

       expect(@post.comments.count).to eql(2)
       expect(comment[1].body).to eql("New Comment")
     end
    end

    describe "edit comment" do
      it "admin is able to edit" do

        @comment = Comment.first
        params = { topic_id: @topic.slug, post_id: @post.slug, id: @comment.id}
        get :edit, params: params, session: { id: @admin.id }

        expect(assigns[:comment]).to eql(@comment)
        expect(subject).to render_template(:edit)
        end
      end

    describe "update comment" do
      it "should deny if user not logged in" do

        @comment = Comment.first
        params = { topic_id: @topic.slug, post_id: @post.slug, id: @comment.id, comment: { body: "Update body" } }
        patch :update, xhr: true, params: params

        expect(flash[:danger]).to eql("You need to login first")
      end

      it "should update comment for admin" do

         session[:id] = @admin.id

         @comment = Comment.first
         params = { topic_id: @topic.slug, post_id: @post.slug, id: @comment.id, comment: { body: "Update Comment" } }
         patch :update, xhr: true, params: params

         @comment.reload

         expect(@comment.body).to eql("Update Comment")
       end
    end

    describe "delete comment" do
      it "should delete comment for user" do

        session[:id] = @user.id
        @comment = Comment.first
        params = { topic_id: @topic.slug, post_id: @post.slug, id: @comment.id }
        delete :destroy, xhr: true, params: params

        comment = Comment.find_by(id: @comment.id)

        expect(@user.comments.count).to eql(0)
      end

      it "should delete comment for admin" do

        session[:id] = @admin.id
        @comment = Comment.first
        params = { topic_id: @topic.id, post_id: @post.id, id: @comment.id }
        delete :destroy, xhr: true, params: params

        comment = Comment.find_by(id: @comment.id)

        expect(@user.comments.count).to eql(0)
      end
    end
  end
