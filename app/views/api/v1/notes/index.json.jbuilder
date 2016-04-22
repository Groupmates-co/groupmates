json.array!(@notes) do |json, note|
	json.partial! 'note', note: note
end