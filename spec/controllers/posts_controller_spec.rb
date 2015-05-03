require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:default_post) { FactoryGirl.create(:post) }
  let(:invalid_post) { FactoryGirl.build(:post, :invalid) }

  describe "Get #index" do
    context "GET index" do
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
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
        post_attributes = default_post.attributes
        post :create, post: post_attributes
        expect(response).to redirect_to Post.last
      end
    end

    context "creates invalid post" do
      it "and redirects to the new template" do
        post_attributes = invalid_post.attributes
        post :create, post: post_attributes
        expect(response).to render_template("new")
      end
    end
  end

end