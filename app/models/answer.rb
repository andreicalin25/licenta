class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :teacher
  belongs_to :student
end
