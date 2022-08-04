class AddRefToAnswerLike < ActiveRecord::Migration[7.0]
  def change
    add_reference :answer_likes, :answer, null: false, foreign_key: true
    add_reference :answer_likes, :user, null: false, foreign_key: true
  end
end
