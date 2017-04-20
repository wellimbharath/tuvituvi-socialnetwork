class AddDetailsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :firstname, :text
    add_column :users, :lastname, :text
    add_column :users, :phone, :integer
    add_column :users, :interest, :string
    add_column :users, :bio, :text
    add_column :users, :dob, :date
  	add_column :users, :webstie, :string
  	add_column :users, :is_female, :boolean, default: false
  end

end
