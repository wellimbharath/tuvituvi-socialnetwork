class AddVideoToPosts < ActiveRecord::Migration
  def up
    add_attachment :posts, :video
  end

  def down
    remove_attachment :posts, :video
  end
end
