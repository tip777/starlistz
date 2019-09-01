
class RemoveAttachmentImageToList < ActiveRecord::Migration[5.0]
  def self.up
    remove_attachment :lists, :image   
  end

  def self.down
    remove_attachment :lists, :image   
  end 
end