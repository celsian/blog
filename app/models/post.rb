class Post < ActiveRecord::Base
  validates :title, :content, presence: true

  default_scope { order("created_at DESC") }

  def error_messages
    messages = ""
    errors.full_messages.each do |message|
      messages += message + ". "
    end
    messages
  end

  def next #returns array with single post in it
    Post.where("posts.created_at > ?", self.created_at).order("posts.created_at ASC").limit(1)
  end

  def previous #returns array with single post in it
    Post.where("posts.created_at < ?", self.created_at).order("posts.created_at DESC").limit(1)
  end

  def next_five
    Post.where("posts.created_at > ?", self.created_at).order("posts.created_at ASC").limit(5)
  end

  def previous_five
    Post.where("posts.created_at < ?", self.created_at).order("posts.created_at DESC").limit(5)
  end

  def self.nextMonth(post_last)
    if post_last && post_last.next.length > 0
        return ["#{post_last.next.first.created_at.strftime("%m%y")}", "#{post_last.next.first.created_at.strftime("%B %Y")}"]
    else
      return false
    end
  end

  def self.previousMonth(post_first)
    if post_first && post_first.previous.length > 0
        return ["#{post_first.previous.first.created_at.strftime("%m%y")}", "#{post_first.previous.first.created_at.strftime("%B %Y")}"]
    else
      return false
    end
  end
end
