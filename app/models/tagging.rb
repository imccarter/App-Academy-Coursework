class Tagging < ActiveRecord::Base
  validates :tag_topic_id, presence: true
  validates :shortened_url_id, presence: true

  belongs_to(
    :topic,
    foreign_key: :tag_topic_id,
    primary_key: :id,
    class_name: "TagTopic"
  )

  belongs_to(
    :url,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "ShortenedUrl"
  )
end
