class CreateTeachersSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers_subjects do |t|
      t.references :teacher, foreign_key: { to_table: 'users'}, null: false, index: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
