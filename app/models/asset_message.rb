class AssetMessage < ActiveRecord::Base	
	
	belongs_to :asset, inverse_of: :asset_messages
	belongs_to :message, inverse_of: :asset_messages

	self.table_name = "assets_messages"
	
end
