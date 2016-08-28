require 'rails_helper'

  RSpec.describe TopicsController, type: :controller do
    before(:all) do
      @admin = create(:user,:admin)
      @user = create(:user)
      @topic = create (:topic)
    end

    describe "index topics" do
      it "should render index" do

        get :index
        expect(assigns[:topics].count).to eql(1)
        expect(subject).to render_template(:index)
      end
    end

    describe "new topic" do
      it "should deny if not logged in" do

        get :new, params: nil
        expect(flash[:danger]).to eql("You need to login first")
      end

      it "should render new for admin" do

        session[:id] = @admin.id
        get :new, params: nil
        expect(subject).to render_template(:new)
      end

      it "should deny user" do

      session[:id] = @user.id
      get :new, params: nil
      expect(flash[:danger]).to eql("You're not authorized")
      end

    end

    describe "create topic" do

    it "should deny if not logged in" do

      params = { topic: { title: "New Title", description: "New Description" } }
      post :create, params: params

      expect(flash[:danger]).to eql("You need to login first")
      end

    it "should create new topic for admin" do

      session[:id] = @admin.id
      params = { topic: { title: "New Title", description: "New Description" } }
      post :create, params: params

      topic = Topic.find_by(title: "New Title")

      expect(Topic.count).to eql(2)
      expect(topic).to be_present
      expect(topic.description).to eql("New Description")
      expect(subject).to redirect_to(topics_path)
      end

    it "should deny user" do

      session[:id] = @user.id
      params = { topic: { title: "New Title", description: "New Description" } }
      post :create, params: params

      expect(flash[:danger]).to eql("You're not authorized")
      end
    end

    describe "edit topic" do

    it "should render edit for admin" do

      session[:id] = @admin.id
      @topic = Topic.first
      get :edit, params: { id: @topic.id }

      expect(assigns[:topic]).to be_present
      expect(subject).to render_template(:edit)
    end

    it "should deny if not logged in" do

      @topic = Topic.first
      get :edit, params: { id: @topic.id }

      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should deny if not admin" do

      session[:id] = @user.id
      @topic = Topic.first
      get :edit, params: { id: @topic.id }

      expect(flash[:danger]).to eql("You're not authorized")
    end
  end

    describe "update topic" do

    it "should update if user is admin" do

      session[:id] = @admin.id
      @topic = Topic.first
      params = { id: @topic.id, topic: { title: "New Title", description: "New Description" } }
      get :update, params: params

      @topic.reload
      expect(@topic.title).to eql("New Title")
      expect(@topic.description).to eql("New Description")
      expect(flash[:success]).to eql("You've updated a topic.")
      expect(subject).to redirect_to(topics_path)
    end

    it "should deny if not logged in" do

      @topic = Topic.first
      params = { id: @topic.id, topic: { title: "New Title", description: "New Description" } }
      get :update, params: params

      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should deny if not admin" do

      session[:id] = @user.id
      @topic = Topic.first
      params = { id: @topic.id, topic: { title: "New Title", description: "New Description" } }
      get :update, params: params

      expect(flash[:danger]).to eql("You're not authorized")
    end

    describe "destroy topic" do

    it "should destroy if user is admin" do

      session[:id] = @admin.id
      @topic = Topic.first
      delete :destroy, params: { id: @topic.id }

      expect(flash[:success]).to eql("Topic deleted")
      expect(Topic.count).to eql(0)
      expect(subject).to redirect_to(topics_path)
    end

    it "should deny if not logged in" do

      @topic = Topic.first
      delete :destroy, params: { id: @topic.id }

      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should deny if not admin" do

      session[:id] = @user.id
      @topic = Topic.first
      delete :destroy, params: { id: @topic.id }

      expect(flash[:danger]).to eql("You're not authorized")
      end
    end
  end
end
