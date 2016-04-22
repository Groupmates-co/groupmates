json.array!(@preferences) do |json, preference|
	json.partial! 'preference', preference: preference
end