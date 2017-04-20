class AddCompleteToDreams < ActiveRecord::Migration
  def change
    add_column :dreams, :complete, :boolean , :default => false
  end
end
