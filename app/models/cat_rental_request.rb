class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }, presence: true
  validates :cat_id, :start_date, :end_date, presence: true
end
