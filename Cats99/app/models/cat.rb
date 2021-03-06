class Cat < ActiveRecord::Base
  COLORS = %w(CALICO TABBY ORANGE BLACK WHITE BROWN SEALPOINT BLUE PURPLE NUDE)

  validates :color, inclusion: { in: COLORS, message: "%{value} is not a cat color as described in this app"}
  validates :sex, inclusion: { in: %w(M F), message: "M or F are our only cat sex options"}, presence: true

  has_many(
    :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "CatRentalRequest"
  )

end
