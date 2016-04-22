class UserFs

	require 'digest/sha1'

	@@users_dir = "#{Rails.root}/public/uploads/users" 

	def self.save_user_picture(file_url)
		hash = Digest::SHA1.hexdigest DateTime.now.to_s
		open("#{@@users_dir}/#{hash}.jpg", "wb") do |file|
			open(file_url) do |uri|
				file.write(uri.read)
				file.path
			end
		end
	end

end