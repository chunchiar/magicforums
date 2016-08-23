require 'rails_helper'

  RSpec.describe PostsController, type: :controller do
    before(:all) do
      @admin = User.create(username: "myadmin", email: "myadmin@gmail.com", password: "myadmin", role:"admin")
      @user = User.create(username:"user6@gmail.com", email: "user6@gmail.com", password: "password")
      @topic = Topic.create ({ title:"Topic 1", description: "Hello there", user_id: @admin.id })
      @post = Post.create({ title: "Post 1", body: "Hello there", topic_id: @topic.id, user_id: @admin.id })
    end

    describe "index posts" do
      it "should render index" do

        params = { topic_id: @topic.slug }
        get :index, params: params

        expect(subject).to render_template(:index)
        expect(Post.count).to eql(1)
      end
    end

    describe "new post" do
      it "should deny if user not logged in" do

        params = { topic_id: @topic.id }
        get :new, params: params

        expect(flash[:danger]).to eql("You need to login first")
      end

      it "should render new for admin" do

        session[:id] = @admin.id
        params = { topic_id: @topic.id }
        get :new, params: params

        expect(assigns[:post]).to be_present
        expect(subject).to render_template(:new)
      end

      it "should deny user" do

      session[:id] = @user.id
      params = { topic_id: @topic.id }
      get :new, params: params

      expect(assigns[:post]).to be_present
      expect(flash[:danger]).to eql("You're not authorized")
      end
    end

    describe "create post" do

      it "should deny if user not logged in" do

        params = { topic_id: @topic.id, post: { title: "New Post", body: "New Super Heavy Body" } }
        post :create, params: params

        expect(flash[:danger]).to eql("You need to login first")
      end

      it "should create new post" do

      session[:id] = @admin.id
      params = { topic_id: @topic.slug, post: { title: "Test New Post", body: "New Post Body" } }
      post :create, params: params

      posts = Post.all

      expect(@admin.posts.count).to eql(2)
      expect(posts[1].title).to eql("Test New Post")
      expect(posts[1].body).to eql("New Post Body")
      expect(posts[1].topic).to eql(@topic)
      expect(subject).to redirect_to(topic_posts_path(@topic))
      end
    end

    describe "edit post" do

      it "should render edit for admin" do

      @post = Post.first
      params = { topic_id: @topic.slug, id: @post.slug}
      get :edit, params: params, session: { id: @admin.id }

      expect(assigns[:post]).to eql(@post)
      expect(subject).to render_template(:edit)
      end

      it "should deny if user not logged in" do

      @post = Post.first
      params = { topic_id: @topic.id, id: @post.id }
      get :edit, params: params

      expect(flash[:danger]).to eql("You need to login first")
     end

       it "should deny if user not authorized" do

       @post = Post.first
       params = { topic_id: @topic.id, id: @post.id }
       get :edit, params: params

       expect(flash[:danger]).to eql("You need to login first")
      end
    end

    describe "update post" do

      it "should render update for admin" do

      session[:id] = @admin.id
      @post = Post.first
      params = { topic_id: @topic.slug, id: @post.slug, post: {title: "Update Title", body: "Update My Body"} }

      patch :update, params: params

      @post.reload

      expect(@post.title).to eql("Update Title")
      expect(@post.body).to eql("Update My Body")
      expect(subject).to redirect_to(topic_posts_path)
      end
    end

    describe "destroy post" do

      it "should deny if user not logged in" do

        @post = Post.first
        params = { topic_id: @topic.id, id: @post.id }
        delete :destroy, params: params

        expect(flash[:danger]).to eql("You need to login first")
      end

      it "should deny if unauthorized user" do

        session[:id] = @user.id
        @post = Post.first
        params = { topic_id: @topic.id, id: @post.id }
        delete :destroy, params: params, session: { id: @user.id }

        expect(flash[:danger]).to eql("You're not authorized")
      end

      it "should destroy if user is admin" do

        session[:id] = @admin.id
        @post = Post.first
        params = { topic_id: @topic.slug, id: @post.slug }
        delete :destroy, params: params, session: { id: @admin.id }
        post = Post.find_by(id: @post.slug)

        expect(@admin.posts.count).to eql(0)
        expect(subject).to redirect_to(topic_posts_path)
      end
    end

end
