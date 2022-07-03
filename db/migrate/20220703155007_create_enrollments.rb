class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: true
      t.references :teachers_subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
