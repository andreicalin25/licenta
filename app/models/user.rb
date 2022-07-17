class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teachers_subjects
  has_many :subjects, through: :teachers_subjects

  validates :role, inclusion: { in: %w(ADMIN TEACHER STUDENT),
                                message: "%{value} must be STUDENT or TEACHER" }, allow_nil: false
end