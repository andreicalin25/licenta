class Student < ApplicationRecord
  belongs_to :group
  has_many :questions
  has_many :answers
end
