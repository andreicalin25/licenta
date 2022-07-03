class AddEnrollmentToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :enrollment, null: false, foreign_key: true
  end
end
