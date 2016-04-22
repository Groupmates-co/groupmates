class AddFolderIdToAssets < ActiveRecord::Migration
  def change
  	add_column :assets, :parent_id, :integer, index: true, null: false, default: 0
  end
end
