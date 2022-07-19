class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :subject_name, null: false
      t.string :activity

      t.timestamps
    end
  end
end
