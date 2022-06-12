class Teacher < ApplicationRecord
  has_many :subjects
  has_many :questions
  has_many :answers
end
