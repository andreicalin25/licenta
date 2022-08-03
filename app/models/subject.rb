class Subject < ApplicationRecord
  has_many :teachers_subjects
  has_many :teachers, through: :teachers_subjects

  validates :activity, inclusion: { in: %w(Curs Seminar Laborator ),
                                message: "%{value} must be Curs/Seminar/Laborator", allow_blank: true }, allow_nil: true

  scope :subjects_of_student, ->(student_id) {where(id: TeachersSubject.of_student(student_id).select(:subject_id))}
  scope :subjects_of_teacher, ->(teacher_id) {where(id: TeachersSubject.of_teacher(teacher_id).select(:subject_id))}
  scope :subjects_not_of_teacher, ->(teacher_id) {where.not(id: TeachersSubject.of_teacher(teacher_id).select(:subject_id))}
end
