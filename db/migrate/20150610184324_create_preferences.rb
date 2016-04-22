class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user, index: true
      t.references :project, index: true
      t.boolean :on_time
      t.integer :from_time
      t.integer :to_time

      t.timestamps null: false
    end
  end
end
