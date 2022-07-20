class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teachers_subjects
  has_many :subjects, through: :teachers_subjects
  has_many :enrollments, dependent: :delete_all

  validates :role, inclusion: { in: %w(ADMIN TEACHER STUDENT),
                                message: "%{value} must be STUDENT or TEACHER" }, allow_nil: false

  scope :teachers, -> {where(role: "TEACHER")}
  scope :students, -> {where(role: "STUDENT")}
end
