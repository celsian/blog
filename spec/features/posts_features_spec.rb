require "rails_helper"

RSpec.feature "posts", :type => :feature do
  let(:post) { FactoryGirl.create(:post) }
  let(:posts) { Post.all }
  
  scenario "show the post content" do
    post1 = FactoryGirl.create(:post, content: "This is the first post content check.")
    visit post_path(post1)
    expect(page).to have_content "This is the first post content check."
  end

end