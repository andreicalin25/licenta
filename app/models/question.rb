class Question < ApplicationRecord
  belongs_to :enrollment
  has_one :student, through: :enrollment
  has_one :teachers_subject, through: :enrollment

  has_many :answers, dependent: :destroy
  has_many :question_likes, dependent: :destroy

  has_many_attached :files, dependent: :destroy

  validates :title, presence: true, length: {minimum: 5}
  validates :title, presence: true, length: {maximum: 150, too_long: "Please keep the title short and specify the details in the appropriate section"}

  validates :importance, inclusion: { in: [1, 2, 3],
                                message: "%{value} must be present - chose 1, 2 or 3" }, allow_nil: false

  scope :asked_by_student, ->(student_id) {joins(:enrollment).where('enrollments.student_id' => student_id)}
  scope :questions_for_student, ->(student_id) {joins(:enrollment).where(enrollments: {teachers_subject: TeachersSubject.of_student(student_id) } )}
  scope :questions_for_student_by_subject, ->(student_id, subject_id) {joins(:enrollment).where(enrollments: {teachers_subject: TeachersSubject.where(subject_id: subject_id).of_student(student_id) } )}
  scope :questions_for_teacher, ->(teacher_id) {joins(:enrollment).where(enrollments: {teachers_subject: TeachersSubject.of_teacher(teacher_id) } )}
  scope :questions_for_teacher_by_subject, ->(teacher_id, subject_id) {joins(:enrollment).where(enrollments: {teachers_subject: TeachersSubject.where(subject_id: subject_id).of_teacher(teacher_id) } )}
  scope :questions_of_teachers_subject, ->(teachers_subject_id) {joins(:enrollment).where(enrollments: {teachers_subject: teachers_subject_id } )}

end
