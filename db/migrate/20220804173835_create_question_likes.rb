class CreateQuestionLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :question_likes do |t|

      t.timestamps
    end
  end
end
