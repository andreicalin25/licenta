class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :text, null: false
      t.integer :votes

      t.timestamps
    end
  end
end
