require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { Post.all }

  describe "post model" do
    before(:each) do 
      @post1 = FactoryGirl.create(:post, content: "This is the first post. Order")
      @post2 = FactoryGirl.create(:post, content: "This is the second post. Order")
    end

    context "with no content" do
      it "should not save" do
        expect(Post.new.save).to be_falsey
      end
    end

    context "new posts" do
      it "order by newest first to oldest last" do
        expect(posts.index(@post2)).to be < posts.index(@post1)
      end
    end

    it ".next returns the next post based on created_at date" do
      expect(@post1.next.first).to be == @post2
    end

    it ".previous returns the next post based on created_at date" do
      expect(@post2.previous.first).to be == @post1
    end
  end
end
