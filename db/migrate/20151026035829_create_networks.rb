class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :network_name
      
      t.timestamps null: false
    end
  end
end
