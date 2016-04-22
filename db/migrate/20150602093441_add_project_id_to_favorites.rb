class AddProjectIdToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :project_id, :integer, index: true
  end
end
