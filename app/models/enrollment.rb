class Enrollment < ApplicationRecord
  belongs_to :student, :class_name => "User"
  belongs_to :teachers_subject

  has_many :questions
  has_one :subject, through: :teachers_subject
  has_one :teacher, through: :teachers_subject

  scope :enrollments_of_student, ->(student_id) {where(student_id: student_id).joins(:teachers_subject)}
end
