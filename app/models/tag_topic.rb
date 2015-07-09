class TagTopic < ActiveRecord::Base
  validates :topic, presence: true

  has_many(
    :taggings,
    foreign_key: :tag_topic_id,
    primary_key: :id,
    class_name: "Tagging"
  )

  has_many(
    :urls,
    through: :taggings,
    source: :url
  )

  # def most_popular_urls(num)
  #   self.urls.order(num_clicks)
  #
  #   SELECT
  #     *
  #   FROM
  #     urls
  #   ORDER BY
  #     num_clicks
  #   LIMIT
  #     num
  # end
end
