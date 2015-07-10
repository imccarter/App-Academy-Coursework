# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true

  has_many(
    :polls,
    class_name: :Poll,
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: :Response,
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many :answer_choices, through: :responses, source: :answer_choice
end
