class AddAnonymousToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :anonymous, :boolean, :default => false
  end
end
