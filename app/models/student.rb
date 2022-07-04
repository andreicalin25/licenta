class Student < ApplicationRecord
  has_many :enrollments
  has_many :teachers_subjects, through: :enrollments

  has_many :answers
end
