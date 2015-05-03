require "rails_helper"

RSpec.feature "posts", :type => :feature do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { Post.all }
  
  describe "show template" do
    scenario "shows the post content" do
      post1 = FactoryGirl.create(:post, content: "This is the first post content check.")
      visit post_path(post1)
      expect(page).to have_content "This is the first post content check."
    end
  end

  describe "new template" do
    scenario "create new post" do
      visit new_post_path
    end
  end

end