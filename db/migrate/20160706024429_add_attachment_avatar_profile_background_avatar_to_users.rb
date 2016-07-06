class AddAttachmentAvatarProfileBackgroundAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :avatar
      t.attachment :profile_background_avatar
    end
  end

  def self.down
    remove_attachment :users, :avatar
    remove_attachment :users, :profile_background_avatar
  end
end
