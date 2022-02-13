class AddColumnsToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :first_user_id, :integer
    add_column :messages, :last_user_id, :integer
  end
end
