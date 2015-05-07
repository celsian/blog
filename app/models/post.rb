class Post < ActiveRecord::Base
  validates :content, presence: true

  default_scope { order("created_at DESC") }

  def error_messages
    messages = ""
    errors.full_messages.each do |message|
      messages += message + "."
    end
    messages
  end

########## THESE ARE NOT FUNCTIONING AS INTENDED
  def next
    (Post.where("posts.id > ?", self.id).order("posts.id ASC").limit(1)).first
  end

  def previous
    (Post.where("posts.id < ?", self.id).order("posts.id DESC").limit(1)).first
  end
  ########## THESE ARE NOT FUNCTIONING AS INTENDED

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
