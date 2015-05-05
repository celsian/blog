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
end
