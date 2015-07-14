class Comment < ActiveRecord::Base
  validates :body, :author_id, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true
end
