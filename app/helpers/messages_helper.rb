module MessagesHelper

	def format_content_assets(message)
		if message.assets.any?
			message.content << " "<< message.assets.first.uploaded.url
			message.content_html
		else
			message.content_html
		end
	end

  def message_picture(message)
		if message.user.profile_picture.blank? 
			message.user.gravatar_url
		else 
			message.user.profile_picture.url
		end
  end
end
