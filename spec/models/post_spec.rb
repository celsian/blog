require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { Post.all }

  describe "post model" do
    context "with no content" do
      it "should not save" do
        expect(Post.new.save).to be_falsey
      end
    end

    context "new posts" do
      it "order by date" do
        post1 = FactoryGirl.create(:post, content: "This is the first post. Order")
        post2 = FactoryGirl.create(:post, content: "This is the second post. Order")

        expect(posts.index(post2)).to be > posts.index(post1)
      end
    end
  end

end
