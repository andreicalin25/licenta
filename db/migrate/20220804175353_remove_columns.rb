class RemoveColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :votes
    remove_column :answers, :votes
  end
end
