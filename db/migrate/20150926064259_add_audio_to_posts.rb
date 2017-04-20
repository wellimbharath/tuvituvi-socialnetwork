class AddAudioToPosts < ActiveRecord::Migration
  def up
    add_attachment :posts, :audio
  end

  def down
    remove_attachment :posts, :audio
  end
end
