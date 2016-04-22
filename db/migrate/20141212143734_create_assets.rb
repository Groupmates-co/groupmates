class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
