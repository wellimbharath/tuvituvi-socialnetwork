class AddStateToUserNetworks < ActiveRecord::Migration
  def change
  	add_column :user_networks, :state, :string
  	add_index :user_networks, :state
  end
  
end
