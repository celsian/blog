require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { Post.all }

  context "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  context "GET show" do
    it "renders the show template" do
      post1 = FactoryGirl.create(:post, content: "This is the first post.")
      get :show, id: post1.id
      expect(response).to render_template("show")
    end
  end

end
