class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :details
      t.integer :importance
      t.integer :votes

      t.timestamps
    end
  end
end
