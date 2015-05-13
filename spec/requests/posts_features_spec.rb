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

  describe "show_recent template" do
    before (:each) do
      0.upto(12) do |num|
          FactoryGirl.create(:post, content: "This is post number #{num}.")
      end
    end

    scenario "shows up to the five most recent posts" do
      visit posts_show_recent_path

      8.upto(12) do |num| #Ensures the last 5 posts are displayed
        expect(page).to have_content "This is post number #{num}."
      end
    end

    scenario "shows next 5 and previous 5" do

    end
  end

  describe "show_by_month template" do
    before(:each) do 
      FactoryGirl.create(:post, content: "This post is from Jan 2015.", created_at: Time.new(2015,1,20, 13,30,0, "-08:00"))
      FactoryGirl.create(:post, content: "This post is from Feb 2015.", created_at: Time.new(2015,2,20, 13,30,0, "-08:00"))
      FactoryGirl.create(:post, content: "This post is from Feb 2015 also.", created_at: Time.new(2015,2,22, 15,24,0, "-08:00"))
      FactoryGirl.create(:post, content: "This post is from March 2015.", created_at: Time.new(2015,3,05, 9,15,0, "-08:00"))
    end

    scenario "shows all posts from a specific month & year" do
      visit posts_show_by_month_path(month_year: "0215")

      expect(page).to have_content "This post is from Feb 2015."
      expect(page).to have_content "This post is from Feb 2015 also."
      expect(page).to have_no_content "This post is from March 2015."
    end

    scenario "displays previous and next month links" do
      visit posts_show_by_month_path(month_year: "0215")

      expect(page).to have_content "March 2015"
      expect(page).to have_content "January 2015"
    end

    scenario "displays next month link only if it exists" do
      visit posts_show_by_month_path(month_year: "0315")

      expect(page).to have_content "February 2015"
      expect(page).to have_no_content "April 2015"
    end

    scenario "displays previous month link only if it exists" do
      visit posts_show_by_month_path(month_year: "0115")

      expect(page).to have_content "February 2015"
      expect(page).to have_no_content "December 2014"
    end
  end

  describe "new template" do
    scenario "creates a new post" do
      visit new_post_path

      fill_in 'Title', with: "This is a test title"
      fill_in 'Content', with: "This is test content."

      click_button "Create Post"
      expect(page).to have_content "This is a test title"
      expect(page).to have_content "This is test content."
    end

    scenario "creates a new post without content" do
      visit new_post_path

      fill_in 'Title', with: "This is some title"
      fill_in 'Content', with: ""

      click_button "Create Post"
      expect(page).to have_content "Error"
    end

    scenario "creates a new post without content" do
      visit new_post_path

      fill_in 'Title', with: ""
      fill_in 'Content', with: "This is some fake content"


      click_button "Create Post"
      expect(page).to have_content "Error"
    end
  end

  describe "edit template" do
    scenario "edit an existing post" do
      visit edit_post_path(id: post)

      expect(page).to have_content "Title"
      expect(page).to have_content "Content"
      expect(page).to have_content post.content
    end
  end

end