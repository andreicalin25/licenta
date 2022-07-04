class AddTeacherToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :teacher, null: true, foreign_key: true
  end
end
