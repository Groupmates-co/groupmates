# LOLCAT feature
# Commented out, seems like the new AutoHtml doesn't have a method
# add_filter for some reasons. @TODO investigation

AutoHtml.add_filter(:lolcats) do |text|
  text.gsub("/lolcat") do |match|
		%|<img src="#{random_image}" alt="LOLCAT #{random_image}"/>|
  end
end

AutoHtml.add_filter(:emojis) do |text|
	ApplicationHelper::emojify(text)
end

def random_image
  ActionController::Base.helpers.asset_path("lolcats/"+Dir.entries(Rails.root.join("app","assets","images","lolcats")).sample)
end
