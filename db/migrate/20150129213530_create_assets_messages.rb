class CreateAssetsMessages < ActiveRecord::Migration
  def change
    create_table :assets_messages, :id => false do |t|
      t.belongs_to :asset, index: true
      t.belongs_to :message, index: true
    end
  end
end
