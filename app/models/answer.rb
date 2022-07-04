class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :teacher, optional: true
  belongs_to :student, optional: true
end
