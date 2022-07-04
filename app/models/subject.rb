class Subject < ApplicationRecord
  has_many :teachers_subjects
  has_many :teachers, through: :teachers_subjects
end
