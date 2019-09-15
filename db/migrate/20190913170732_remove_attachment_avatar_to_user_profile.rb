class RemoveAttachmentAvatarToUserProfile < ActiveRecord::Migration[5.0]
    def self.up
        remove_attachment :user_profiles, :avatar  
    end

    def self.down
        remove_attachment :user_profiles, :avatar
    end
end  