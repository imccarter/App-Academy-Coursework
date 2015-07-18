# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  author_id  :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :author_id, :post_id, :content, presence: true

  belongs_to :post
  belongs_to(
    :author,
    foreign_key: :author_id,
    class_name: :User
  )

  has_many(
    :child_comments,
    foreign_key: :parent_comment_id,
    class_name: :Comment,
    dependent: :destroy
  )
end
