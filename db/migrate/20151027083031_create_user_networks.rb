class CreateUserNetworks < ActiveRecord::Migration
  def change
    create_table :user_networks do |t|
    t.integer :user_id
      t.integer :friend_id
      t.timestamps
    end
     add_index :user_networks, [:user_id, :friend_id]
  end
end

