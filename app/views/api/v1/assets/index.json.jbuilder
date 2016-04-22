#result =  []

# json.array!(@assets) do |json, asset|
# 	json.partial! 'asset', asset: asset
# end

# if @with_folders
# 	json.array!(@folders) do |json, folder|
# 		json.partial! 'api/v1/folders/folder', folder: folder
# 	end
# end

json.array!(Array.new)

@assets.each do |asset|   
  json.child!{|json| json.partial! 'asset', asset: asset}        
end

if @with_folders
	@folders.each do |folder|   
	  json.child!{|json| json.partial! 'api/v1/folders/folder', folder: folder}        
	end
end

# @assets.each do |asset|
#   result << json.partial! 'asset', asset: asset
# end

# if @with_folders
# 	@folders.each do |folder|
#   	result << json.partial! 'api/v1/folders/folder', folder: folder
#   end
# end
# # at this point result will be an array of companies and people which just needs converting to json.
# json.array!(result)