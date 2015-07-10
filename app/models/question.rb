# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  has_many(
    :answer_choices,
    class_name: :AnswerChoice,
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: :Poll,
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  # def results
  #   hash = Hash.new { |hash, key| hash[key] = 0 }
  #   answer_choices.each do |ac|
  #     hash[ac] += ac.responses.count
  #   end
  #   hash
  # end

  def results
    results_hash = Hash.new { |hash, key| hash[key] = 0 }
    answer_choices.includes(:responses).each do |choice|
      results_hash[choice.text] += choice.responses.length
    end

    results_hash
  end

  SELECT
    ac.text, COUNT(r)
  FROM
    answer_choices ac
  JOIN
    responses r ON r.answer_choice_id = ac.id
  GROUP BY
    ac.id 

end
