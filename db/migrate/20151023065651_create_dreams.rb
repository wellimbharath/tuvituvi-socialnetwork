class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
    	 t.string :dream
    
      t.timestamps null: false
    end
  end
end
