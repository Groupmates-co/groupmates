class AddAttachmentUploadedFileToAssets < ActiveRecord::Migration
  def self.up
    change_table :assets do |t|
      t.attachment :uploaded
    end
  end

  def self.down
    remove_attachment :assets, :uploaded
  end
end
