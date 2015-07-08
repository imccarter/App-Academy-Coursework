class Visit < ActiveRecord::Base
  validates :shortened_url_id, presence: true
  validates :user_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(
      shortened_url_id: shortened_url.id,
      user_id: user.id
    )
  end

  belongs_to(
    :shortened_url,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "ShortenedUrl"
  )

  belongs_to(
    :visitor
    foreign_key: :user_id
    primary_key: :id
    class_name: "User"
  )
end
