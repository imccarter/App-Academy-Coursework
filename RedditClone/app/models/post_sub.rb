# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ActiveRecord::Base
  validates :post, :sub, presence: true

  belongs_to(
    :sub,
    foreign_key: :sub_id,
    class_name: :Sub,
    inverse_of: :post_subs
  )

  belongs_to(
    :post,
    foreign_key: :post_id,
    class_name: :Post,
    inverse_of: :post_subs
  )
end
