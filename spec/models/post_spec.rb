require 'rails_helper'

RSpec.describe Post, type: :model do

  context "with no content" do
    it "should not save" do
      expect(Post.new.save).to be_falsey
    end
  end


end
