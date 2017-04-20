class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|

      t.timestamps null: false
    end
  end
end
