json.array!(@favorites) do |json, favorite|
	json.partial! 'favorite', favorite: favorite
end