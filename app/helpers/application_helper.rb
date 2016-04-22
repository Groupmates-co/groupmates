module ApplicationHelper

	def user_image_url(style,user = nil)
		if(user)
			(user.profile_picture.blank?) ? user.gravatar_url(default: User::DEFAULT_PROFILE_PICTURE) : user.profile_picture.url(style)
		else 
			(current_user.profile_picture.blank?) ? current_user.gravatar_url(default: User::DEFAULT_PROFILE_PICTURE) : current_user.profile_picture.url(style)
		end
	end

	def provider_icon(provider)
		case provider
		when "facebook"
		  "fa fa-facebook-square"
		when 'google_oauth2'
			"fa fa-google-plus-square"
		else
			""
		end
	end

  def foundation_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def self.emojify(content)
    
		content.to_s
      .gsub(/:(\)|-\))(\s|$)/, ':blush:') # :)
      .gsub(';)', ':wink:') # ;)
      .gsub(/:D(\s|$)/, ':smiley:') # :D
      .gsub(/[xX]D(\s|$)/, ':laughing:')
      .gsub(/[:;]('\(|\()(\s|$)/,':cry:')
      .gsub(/:[pP](\s|$)/, ':stuck_out_tongue:')
      .gsub(/x[pP](\s|$)/, ':stuck_out_tongue_closed_eyes:')
      .gsub(/(\s|^)[xX][oO](\s|$)/,' :dizzy_face:')
      .gsub(/:[xX](\s|$)/,':no_mouth:')
      .gsub(/(\s|$)B\)(\s|$)/, ':sunglasses:')
      .gsub(/:[sS](\s|$)/, ':confounded:')
      .gsub(':&lt;',':frowning:')
      .gsub(/:[oO](\s|$)/, ':open_mouth:')
      .gsub(':|', ':expressionless:')
      .gsub(/(\s|^):\//, ' :expressionless:')
      .gsub(':(', ':disappointed:')
      .gsub(/;[pP](\s|$)/,':stuck_out_tongue_winking_eye:')
      .gsub(':*',':kissing:')
      .gsub('0:)',':innocent:')
      .gsub('&lt;3',':heart:')
      .gsub('&lt;/3',':broken_heart:')
      .gsub(/[:;]3(\s|$)/,':smile_cat:')
      .gsub('(a)', ':angel:')
      .gsub('(b)', ':beer:')
      .gsub('(bee)', ':honeybee:')
      .gsub('(c)', ':coffee:')
      .gsub('(cake)', ':cake:')
      .gsub('(cn)', ':cn:')
      .gsub('(d)', ':dog:')
      .gsub('(de)',':de:')
      .gsub('(e)', ':envelope:')
      .gsub('(es)', ':es:')
      .gsub('(f)', ':fire:')
      .gsub('(fr)',':fr:')
      .gsub('(g)', ':ghost:')
      .gsub('(h)', ':hamster:')
      .gsub('(i)', ':ice_cream:')
      .gsub('(it)', ':it:')
      .gsub('(j)', ':jack_o_lantern:')
      .gsub('(jp)', ':jp:')
      .gsub('(k)', ':kiss:')
      .gsub('(kr)', ':kr:')
      .gsub('(l)', ':sparkling_heart:')
      .gsub('(m)', ':moneybag:')
      .gsub('(n)', ':thumbsdown:')
      .gsub('(o)', ':octopus:')
      .gsub('(p)', ':penguin:')
      .gsub('(panda)',':panda_face:')
      .gsub('(q)', ':question:')
      .gsub('(r)', ':rabbit:')
      .gsub('(ru)', ':ru:')
      .gsub('(s)', ':sunny:')
      .gsub('(t)', ':tiger:')
      .gsub('(u)', ':unlock:')
      .gsub('(umad)', ':trollface:')
      .gsub('(uk)', ':uk:')
      .gsub('(us)', ':us:')
      .gsub('(v)', ':v:')
      .gsub('(w)', ':whale:')
      .gsub('(x)', ':x:')
      .gsub('(y)', ':thumbsup:')
      .gsub('(z)', ':zzz:')
      .gsub('._.',':neutral_face:')
      .gsub(/[tT]_[tT](\s|$)/,  ':sob:')
      .gsub(/[zZ]_[zZ](\s|$)/, ':sleeping:')
      .gsub(/[Oo]_[Oo](\s|$)/, ':anguished:')
      .gsub(/n_n(\s|$)/,':yum:')
    	.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}")}" class="emoji" style="display: inline" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end

  def call_emojify
    ApplicationHelper.emojify
  end

end
