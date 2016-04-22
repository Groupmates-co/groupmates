class AddCreatorToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :creator, :integer, index: true
  end
end
