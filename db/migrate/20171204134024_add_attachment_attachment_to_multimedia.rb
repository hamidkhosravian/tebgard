class AddAttachmentAttachmentToMultimedia < ActiveRecord::Migration[5.1]
  def self.up
    change_table :multimedia do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :multimedia, :attachment
  end
end
