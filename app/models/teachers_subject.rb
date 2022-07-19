class TeachersSubject < ApplicationRecord
  belongs_to :teacher, :class_name => "User"
  belongs_to :subject

  has_many :enrollments
  has_many :students, through: :enrollments

  scope :subjects_of_teacher, ->(teacher_id) {where(teacher_id: teacher_id).joins(:subject)}
end
