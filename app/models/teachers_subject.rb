class TeachersSubject < ApplicationRecord
  belongs_to :teacher, :class_name => "User"
  belongs_to :subject

  has_many :enrollments
  has_many :students, through: :enrollments

  scope :of_teacher, ->(teacher_id) {where(teacher_id: teacher_id).joins(:subject)}

  # scope :subjects_not_of_teacher, ->(teacher_id) {where.not(id: TeachersSubject.select(:subject_id).where(teacher_id: teacher_id))}
  scope :of_student, ->(student_id) {where(id: Enrollment.select(:teachers_subject_id).where(student_id: student_id))}
  scope :teachers_subjects_not_of_student, ->(student_id) {where.not(id: Enrollment.select(:teachers_subject_id).where(student_id: student_id))}
end
