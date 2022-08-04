class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  scope :of_question, ->(question_id) {where(question_id: question_id)}
end
