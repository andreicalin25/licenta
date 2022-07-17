class Enrollment < ApplicationRecord
  belongs_to :student, :class_name => "User"
  belongs_to :teachers_subject

  has_many :questions
end
