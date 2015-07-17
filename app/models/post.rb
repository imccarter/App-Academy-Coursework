# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :subs, length: { minimum: 1 }
  # validate :at_least_one_sub

  has_many :comments

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

  belongs_to(
    :author,
    class_name: :User,
    foreign_key: :author_id
  )

  has_many(
    :post_subs,
    foreign_key: :post_id,
    class_name: :PostSub,
    inverse_of: :post
  )

  # def at_least_one_sub
  #   if subs.empty?
  #     errors[:subs] << "A post needs to be in at least one sub"
  #   end
  # end
end
