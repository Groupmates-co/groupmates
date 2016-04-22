json.array!(@invitations) do |invitation|
	json.partial! 'invitation', invitation: invitation
end