class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.references :project, index: true
      t.boolean :permission

      t.timestamps
    end
  end
end
