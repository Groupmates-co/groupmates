class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :happening
      t.references :project, index: true

      t.timestamps
    end
  end
end
