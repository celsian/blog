class Post < ActiveRecord::Base
  validates :content, presence: true

  default_scope { order("created_at") }
end
