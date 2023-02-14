class AddLikesCountToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :answer_likes_count, :integer
  end
end
