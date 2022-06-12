class Question < ApplicationRecord
  has_many :answers
  belongs_to :student
  belongs_to :subject
  belongs_to :teacher
end
