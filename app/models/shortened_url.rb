class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true

  belongs_to(
    :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: "User"
  )

  has_many(
    :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "Visit"
  )

  has_many(
    :visitors,
    through: :visits,
    source: :visitor
  )

  def self.random_code
    short_url = SecureRandom::urlsafe_base64
    while self.exists?(short_url: short_url)
      short_url = SecureRandom::urlsafe_base64
    end
    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(short_url: ShortenedUrl.random_code,
      submitter_id: user.id,
      long_url: long_url
    )
  end

end
