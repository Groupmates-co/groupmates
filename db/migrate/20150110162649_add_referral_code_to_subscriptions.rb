class AddReferralCodeToSubscriptions < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :referral_code, :string
  	add_column :subscriptions, :referrer_id, :integer
  end
end
