class AddRefToQuestionLike < ActiveRecord::Migration[7.0]
  def change
    add_reference :question_likes, :question, null: false, foreign_key: true
    add_reference :question_likes, :user, null: false, foreign_key: true
  end
end
