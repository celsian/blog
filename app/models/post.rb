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

  def self.nextMonth(startTime)
    if Post.where(created_at: (startTime+1.month)..(startTime+2.months)).length > 0
      return ["#{(startTime+1.month).strftime("%m%y")}",
        "#{(startTime+1.month).strftime("%B %Y")}"]
    else
      return false
    end
  end

  def self.previousMonth(startTime)
    if Post.where(created_at: (startTime-1.month)..(startTime)).length > 0
      return ["#{(startTime-1.month).strftime("%m%y")}",
        "#{(startTime-1.month).strftime("%B %Y")}"]
    else
      return false
    end
  end
end
