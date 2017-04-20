class AddUserIdToDreams < ActiveRecord::Migration
  def change
    add_column :dreams, :user_id, :string
    add_column :dreams, :integer, :string
  end
end
