class CreateAnswerLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_likes do |t|

      t.timestamps
    end
  end
end
