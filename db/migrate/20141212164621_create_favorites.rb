class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :message, index: true
      t.text :content

      t.timestamps
    end
  end
end
