class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :feedback
      t.references :user, index: true

      t.timestamps
    end
  end
end
