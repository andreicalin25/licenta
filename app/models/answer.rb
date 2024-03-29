class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many :answer_likes, dependent: :destroy

  has_many_attached :files, dependent: :destroy

  validates :text, presence: true

  scope :written_by_user, ->(user_id) {where(user_id: user_id)}
  scope :of_question, ->(question_id) {where(question_id: question_id)}
  scope :of_teachers_subject, ->(teacher_subject) {where(question_id: Question.questions_of_teachers_subject(teacher_subject))}
end
