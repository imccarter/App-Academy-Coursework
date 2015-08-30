class Goal < ActiveRecord::Base
  validates  :user_id, :title, :content, presence: true
  validates :private_goal, inclusion: [true, false]

  belongs_to :user


end
