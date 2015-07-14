class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many(
    :contacts,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Contact",
    dependent: :destroy
  )

  has_many(
    :contact_shares,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "ContactShare",
    dependent: :destroy
  )

  has_many :shared_contacts, through: :contact_shares, source: :contact

  def all_owned_contacts
    self.contacts
  end

  def all_shared_contacts
    self.contact_shares
  end

  def all_contacts
    all_owned_contacts + all_shared_contacts
  end
end
