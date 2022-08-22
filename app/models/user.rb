class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teachers_subjects, dependent: :destroy
  has_many :subjects, through: :teachers_subjects
  has_many :enrollments, dependent: :destroy
  has_many :question_likes, dependent: :destroy
  has_many :answer_likes, dependent: :destroy

  # validates :email, presence: true
  validates_format_of :email,:with => Devise::email_regexp
  validates :last_name, length: { minimum: 2 }
  validates :first_name, length: { minimum: 2 }

  validates :role, inclusion: { in: %w(ADMIN TEACHER STUDENT),
                                message: "%{value} must be STUDENT or TEACHER" }, allow_nil: false

  scope :teachers, -> {where(role: "TEACHER")}
  scope :students, -> {where(role: "STUDENT")}
end
