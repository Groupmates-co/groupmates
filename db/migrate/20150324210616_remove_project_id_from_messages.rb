class RemoveProjectIdFromMessages < ActiveRecord::Migration
  def change
  	Rake::Task['migrate_to_multi_channel'].invoke
    remove_column :messages, :project_id, :integer
  end
end
