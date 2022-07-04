class Teacher < ApplicationRecord
  has_many :teachers_subjects
  has_many :subjects, through: :teachers_subjects

  has_many :answers
end
