class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many :answer_likes, dependent: :destroy

  scope :of_question, ->(question_id) {where(question_id: question_id)}
end
