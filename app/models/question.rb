class Question < ApplicationRecord
  belongs_to :enrollment
  has_one :student, through: :enrollment
  has_one :teachers_subject, through: :enrollment

  has_many :answers

  scope :asked_by_student, ->(student_id) {joins(:enrollment).where('enrollments.student_id' => student_id)}
  scope :questions_for_student, ->(student_id) {joins(:enrollment).where(enrollments: {teachers_subject: TeachersSubject.of_student(student_id) } )}
  scope :questions_for_student_by_subject, ->(student_id, subject_id) {joins(:enrollment).where(enrollments: {teachers_subject: TeachersSubject.where(subject_id: subject_id).of_student(student_id) } )}
  scope :questions_for_teacher, ->(teacher_id) {joins(:enrollment).where(enrollments: {teachers_subject: TeachersSubject.of_teacher(teacher_id) } )}
  scope :questions_for_teacher_by_subject, ->(teacher_id, subject_id) {joins(:enrollment).where(enrollments: {teachers_subject: TeachersSubject.where(subject_id: subject_id).of_teacher(teacher_id) } )}

end
