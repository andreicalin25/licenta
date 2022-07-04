class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :teachers_subject

  has_many :questions
end
