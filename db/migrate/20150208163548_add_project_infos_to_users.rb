class AddProjectInfosToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :last_project_opened, :integer, index: true
  	add_column :users, :last_project_quit, :datetime
  end
end
