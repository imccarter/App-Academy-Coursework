# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :string
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, uniqueness: true, presence: true
  validates :moderator_id, presence: true

  has_many(
    :posts,
    through: :post_subs,
    source: :post,
    dependent: :destroy
  )

  has_many(
    :post_subs,
    foreign_key: :sub_id,
    class_name: :PostSub,
    dependent: :destroy,
    inverse_of: :sub
  )
end
