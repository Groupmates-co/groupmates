json.content '<p>It seems like you are alone here, invite your groupmates in the <a href="#mates"><strong>Mates</strong></a> section <img alt="blush" src="/assets/emoji/unicode/1f60a.png" class="emoji" style="display: inline" width="20" height="20"></p>'
json.created_at Time.now

json.user do
  json.fullname "#{@message.user.first_name} #{@message.user.last_name}"
  json.profile_picture @message.user.profile_picture
end