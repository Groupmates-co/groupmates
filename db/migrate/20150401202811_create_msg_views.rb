class CreateMsgViews < ActiveRecord::Migration
  def change
    create_table :msg_views do |t|
      t.references :channel, index: true
      t.references :user, index: true
      t.references :message, index: true

      t.timestamps
    end
  end
end
