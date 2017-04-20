class AddTermsAndServicesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :terms, :boolean, default: false
    add_index :users, :terms
  end
end
