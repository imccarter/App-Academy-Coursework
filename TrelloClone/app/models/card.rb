class Card < ActiveRecord::Base
  belongs_to :list
  has_many :todo_items
end
