class Subject < ApplicationRecord
  has_many :teachers_subjects, dependent: :destroy
  has_many :teachers, through: :teachers_subjects

  validates :subject_name, presence: true
  validates :activity, inclusion: { in: %w(Curs Seminar Laborator ),
                                message: "%{value} must be Curs/Seminar/Laborator", allow_blank: true }, allow_nil: true

  scope :subjects_of_student, ->(student_id) {where(id: TeachersSubject.of_student(student_id).select(:subject_id))}
  scope :subjects_of_teacher, ->(teacher_id) {where(id: TeachersSubject.of_teacher(teacher_id).select(:subject_id))}
  scope :subjects_not_of_teacher, ->(teacher_id) {where.not(id: TeachersSubject.of_teacher(teacher_id).select(:subject_id))}

  def self.subject_names
    self.distinct.pluck(:subject_name)
  end
end
