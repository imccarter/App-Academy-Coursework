# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cant_respond_to_own_poll

  belongs_to(
    :user,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: :AnswerChoice,
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question #Check with TA

  def respondent_has_not_already_answered_question
    if self.sibling_responses.exists?(["user_id = ?", self.user_id])
      errors[:response] << "User can only respond to a question once!"
    end
  end

  def sibling_responses
    if self.id.nil?
      self.question.responses
    else
      self.question.responses.where('responses.id != ?', self.id)
    end
  end

  def author_cant_respond_to_own_poll
    if self.question.poll.author_id == self.user_id
      errors[:response] << "Author can't respond to own poll"
    end
  end

end
