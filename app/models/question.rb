class Question < ApplicationRecord
  belongs_to :enrollment
  has_one :student, through: :enrollment
  has_one :teachers_subject, through: :enrollment

  has_many :answers
end
