class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.boolean :is_main
      t.boolean :is_private
      t.timestamps null: false
    end
  end
end
