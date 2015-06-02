require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:default_post) { FactoryGirl.create(:post) }
  let(:invalid_post) { FactoryGirl.build(:post, :invalid) }

  describe "Get #index" do
    context "GET index" do
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
        # expect(response).to redirect_to(post_path(Post.last))
      end
    end
  end

  describe "Get #show" do
    context "for existing post" do
      it "renders the show template" do
        get :show, id: default_post.id
        expect(response).to render_template("show")
      end
    end
  end

  describe "Get #show_recent" do
    context "for the last 5 posts" do
      it "renders the show_recent posts" do
        get :show_recent
        expect(response).to render_template("show_recent")
      end
    end
  end

  describe "Get #show_by_month" do
    context "show posts from a single month" do
      it "renders the show_by_month posts" do
        get :show_by_month, month_year: "0100"
        expect(response).to render_template("show_by_month")
      end
    end
  end

  describe "GET #new" do
    context "with valid attributes" do
      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end
    end
  end

  describe "POST #create" do
    context "creates valid post" do
      it "and redirects to the post" do
        post :create, post: default_post.attributes
        expect(response).to redirect_to Post.first
      end
    end

    context "creates invalid post" do
      it "and redirects to the new template" do
        post :create, post: invalid_post.attributes
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    context "post" do
      it "renders the edit template" do
        get :edit, id: default_post
        expect(response).to render_template("edit")
      end
    end
  end

  describe "PUT #update" do
    it "updates the post object" do
      post_attributes = {title: "Title updated", content: "Content updated"}
      put :update, post: post_attributes

      expect(response).to redirect_to post.id
    end
  end

end