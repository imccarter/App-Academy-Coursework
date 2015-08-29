class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }, presence: true
  validates :cat_id, :start_date, :end_date, presence: true
  validate :request_overlaps

  belongs_to(
    :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "Cat",
    dependent: :destroy
  )

  def all_approved_requests_for_cat
    CatRentalRequest.where(cat_id: self.cat_id, status: "APPROVED")
  end

  def request_overlaps
    other_requests = self.all_approved_requests_for_cat.where('id != ?', self.id)
    .where('(? BETWEEN start_date AND end_date) OR
    (? BETWEEN start_date AND end_date) OR
    ((? < start_date) AND (? > end_date))', self.start_date, self.end_date, self.start_date, self.end_date)

    errors[:cat_id] << "Schedule overlap!" unless other_requests.empty?
  end

  def overlapping_approved_requests
  end
end
