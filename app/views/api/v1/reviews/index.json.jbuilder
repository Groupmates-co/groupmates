json.array!(@reviews) do |json, review|
	json.partial! 'review', review: review
end