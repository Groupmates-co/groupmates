json.array!(@folders) do |json, folder|
	json.partial! 'folder', folder: folder
end