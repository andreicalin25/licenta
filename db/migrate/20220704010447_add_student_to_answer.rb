class AddStudentToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :student, null: true, foreign_key: true
  end
end
