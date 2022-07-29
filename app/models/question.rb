class Question < ApplicationRecord
  belongs_to :enrollment
  has_one :student, through: :enrollment
  has_one :teachers_subject, through: :enrollment

  has_many :answers

  scope :questions_of_student, ->(student_id) {joins(:enrollment).where('enrollments.student_id' => student_id)}
end
