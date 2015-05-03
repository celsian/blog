require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { Post.all }

  describe "Get #index" do
    context "GET index" do
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end
  end

  describe "Get #show" do
    context "GET show" do
      it "renders the show template" do
        post1 = FactoryGirl.create(:post, content: "This is the first post. Show")

        get :show, id: post1.id
        expect(response).to render_template("show")
      end
    end
  end

  describe "GET #new" do
    context "GET new" do
      it "renders the new template" do
        get :new
      end
    end
  end

end