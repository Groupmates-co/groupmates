class Emoji
  def emojify(content)
		h(content).to_str
      .gsub(' :)', ' :smile:')
      .gsub(' ;)', ' :wink:')
      .gsub(' :D', ' :laughing:')
      .gsub(' :P', ' :stuck_out_tongue:')
      .gsub(' :p', ' :stuck_out_tongue:')
      .gsub(' :O', ' :open_mouth:')
      .gsub(' :o', ' :open_mouth:')
      .gsub(' :|', ' :expressionless:')
      .gsub(' :/', ' :disappointed:')
      .gsub(' :(', ' :disappointed:')    
    	.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end
end