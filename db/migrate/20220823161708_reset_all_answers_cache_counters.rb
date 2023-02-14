class ResetAllAnswersCacheCounters < ActiveRecord::Migration[7.0]
  def up
    Answer.all.each do |answer|
      Answer.reset_counters(answer.id, :answer_likes)
    end
  end

  def down
    # no rollback needed
  end
end
