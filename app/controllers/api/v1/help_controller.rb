class Api::V1::HelpController < ActionController::Base

	skip_before_filter :authenticate_user_from_token
	respond_to :json
	before_filter :set_bot_message

	def welcome
	end

	def invitation
	end

	protected
		def set_bot_message
			@message = Message.new
			@message.user = User.find_by(admin: 2)
		end
end