class CreateBiographies < ActiveRecord::Migration
  def change
    create_table :biographies do |t|

      t.timestamps null: false
    end
  end
end
