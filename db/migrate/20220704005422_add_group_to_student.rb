class AddGroupToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :group, :string
  end
end
