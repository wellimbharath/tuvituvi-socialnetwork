class CreateCreates < ActiveRecord::Migration
  def change
    create_table :creates do |t|

      t.timestamps null: false
    end
  end
end
