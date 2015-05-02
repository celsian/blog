require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { Post.all }

  it "orders by date" do
    post1 = FactoryGirl.create(:post, content: "This is the first post.")
    post2 = FactoryGirl.create(:post, content: "This is the second post.")

    expect(posts.index(post2)).to be > posts.index(post1)
  end
end
